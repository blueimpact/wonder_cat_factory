class Product < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, autosave: true, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy

  validates :title, presence: true
  validates :price,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :goal,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  scope :ready, -> { active.with_picture }
  scope :active, -> { where(arel_table[:closes_on].gt(Time.zone.tomorrow)) }
  scope :with_picture, -> { where(arel_table[:pictures_count].gt(0)) }
  scope :without_picture, -> { where(pictures_count: 0) }

  scope :bidden_by, ->(user) { joins(:bids).where(bids: { user: user }) }

  def progress
    @progress ||= (bids_count.to_f / goal)
  end

  def percentage
    progress * 100
  end

  def with_picture?
    pictures.present?
  end
end
