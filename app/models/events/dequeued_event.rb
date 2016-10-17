class Events::DequeuedEvent < Events::RegularEvent
  validates :bid_id, presence: true, uniqueness: true

  def self.trigger bid
    create product_id: bid.product_id, bid: bid, created_at: bid.accepted_at
  end
end
