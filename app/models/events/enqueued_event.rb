class Events::EnqueuedEvent < Events::RegularEvent
  validates :bid_id, presence: true, uniqueness: true

  def self.trigger bid
    create(product_id: bid.product_id, bid: bid, created_at: bid.created_at)
      .tap(&:try_trigger_goaled_event)
  end

  def try_trigger_goaled_event
    Events::GoaledEvent.trigger product if product.goaling?
  end
end
