class Product < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, autosave: true, dependent: :destroy

  validates :title, presence: true
end
