class Picture < ActiveRecord::Base
  belongs_to :product, counter_cache: true

  mount_uploader :image, ImageUploader

  validates :image, presence: true
end
