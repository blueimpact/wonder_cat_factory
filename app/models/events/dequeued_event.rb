class Events::DequeuedEvent < Events::RegularEvent
  validates :bid_id, presence: true, uniqueness: true

  def self.trigger bid
    create bid: bid
  end
end
