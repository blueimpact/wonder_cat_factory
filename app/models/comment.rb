class Comment < ActiveRecord::Base
  include TimeScopes

  belongs_to :user
  belongs_to :product
  belongs_to :event

  validates :body, presence: true
end
