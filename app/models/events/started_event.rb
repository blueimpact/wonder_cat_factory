class Events::StartedEvent < Events::RegularEvent
  validates :product_id, uniqueness: true

  def self.trigger product
    create product: product, created_at: product.started_at
  end
end
