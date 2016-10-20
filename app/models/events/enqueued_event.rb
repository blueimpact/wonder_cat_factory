class Events::EnqueuedEvent < Events::RegularEvent
  validates :bid_id, presence: true, uniqueness: true

  def self.trigger bid
    create(product_id: bid.product_id, bid: bid, created_at: bid.created_at)
      .tap(&:deliver_to_seller)
      .tap(&:deliver_to_user)
      .tap(&:try_goaling)
  end

  def try_goaling
    product.with_lock do
      product.update! goaled_at: Time.current if product.goaling?
    end
  end
end
