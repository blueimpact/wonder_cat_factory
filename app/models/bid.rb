class Bid < ActiveRecord::Base
  include TimeScopes
  include EventTrigger

  belongs_to :user
  belongs_to :product, counter_cache: true, touch: true
  has_many :events, -> { older_first }, dependent: :destroy

  validates :user, presence: true
  validates :product, presence: true, uniqueness: { scope: :user }

  scope :accepted, -> { where.not(accepted_at: nil) }
  scope :not_accepted, -> { where(accepted_at: nil) }
  scope :paid, -> { where.not(paid_at: nil) }
  scope :unpaid, -> { where(paid_at: nil) }

  triggers Events::EnqueuedEvent, :created_at
  triggers Events::DequeuedEvent, :accepted_at

  def queue_index
    product.bids.where(Bid.arel_table[:created_at].lt(created_at)).count
  end
end
