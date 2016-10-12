class Events::StartedEvent < Events::RegularEvent
  validates :product_id, uniqueness: true

  def self.trigger product
    product.with_lock do
      product.touch :started_at unless product.started?
      create product: product, created_at: product.started_at
    end
  end
end
