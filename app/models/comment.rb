class Comment < ActiveRecord::Base
  include TimeScopes

  belongs_to :user
  belongs_to :product

  validates :body, presence: true
end
