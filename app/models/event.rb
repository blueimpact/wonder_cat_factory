class Event < ActiveRecord::Base
  belongs_to :bid

  validates :bid_id, presence: true

  def self.trigger *_
    raise 'Not Implemented'
  end
end
