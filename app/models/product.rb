class Product < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, autosave: true, dependent: :destroy

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

  def progress
    @progress ||= (bids_count.to_f / goal)
  end

  def has_picture?
    pictures.length > 0
  end
end
