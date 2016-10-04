class Events::StartedEvent < Events::RegularEvent
  validates :bid_id, uniqueness: true

  def self.trigger bid
    create bid: bid
  end
end
