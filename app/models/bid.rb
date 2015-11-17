class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :product, counter_cache: true

  validates :user, presence: true
  validates :product, presence: true, uniqueness: { scope: :user }
end
