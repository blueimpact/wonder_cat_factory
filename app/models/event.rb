class Event < ActiveRecord::Base
  include TimeScopes

  belongs_to :product
  belongs_to :bid

  validates :product_id, presence: true

  def self.trigger *_
    raise 'Not Implemented'
  end
end
