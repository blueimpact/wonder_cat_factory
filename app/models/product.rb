class Product < ActiveRecord::Base
  include TimeScopes
  include EventTrigger

  belongs_to :user
  has_many :pictures, autosave: true, dependent: :destroy
  has_many :bids, inverse_of: :product, dependent: :destroy do
    def by user
      where(user: user)
    end
  end
  has_many :events, -> { older_first },
           inverse_of: :product,
           dependent: :destroy do
    def for user
      bid_is_nil = Event.arel_table[:bid_id].eq(nil)
      bid_user_is_arg_user = Bid.arel_table[:user_id].eq(user.id)
      joins('LEFT OUTER JOIN bids ON bids.id = events.bid_id')
        .where(bid_is_nil.or(bid_user_is_arg_user))
    end
  end
  has_many :comments, -> { newer_first }, dependent: :destroy
  has_many :instructions, dependent: :destroy
  has_one :dequeued_instruction, class_name: 'Instructions::DequeuedInstruction'

  validates :title, presence: true
  validates :price,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :goal,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :pictures, presence: true, if: -> { started_at.present? }

  scope :ready, -> { active.with_picture }
  scope :active, -> { where(arel_table[:closes_on].gt(Time.zone.tomorrow)) }
  scope :with_picture, -> { where(arel_table[:pictures_count].gt(0)) }
  scope :without_picture, -> { where(pictures_count: 0) }
  scope :started, -> { where.not(started_at: nil) }
  scope :goaled, -> { where.not(goaled_at: nil) }

  scope :bidden_by, ->(user) { joins(:bids).where(bids: { user: user }) }

  triggers Events::StartedEvent, :started_at
  triggers Events::GoaledEvent, :goaled_at

  def progress
    @progress ||= (bids_count.to_f / goal)
  end

  def percentage
    progress * 100
  end

  def with_picture?
    pictures.present?
  end

  def started?
    started_at?
  end

  def goaled?
    goaled_at?
  end

  def goaling?
    !goaled? && bids_count >= goal
  end
end
