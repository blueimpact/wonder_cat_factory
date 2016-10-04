class Events::EnqueuedEvent < Events::RegularEvent
  validates :bid_id, uniqueness: true

  def self.trigger bid
    create bid: bid,
           created_at: bid.created_at,
           updated_at: bid.updated_at
  end
end
