class Events::GoaledEvent < Events::RegularEvent
  validates :product_id, uniqueness: true

  def self.trigger product
    product.with_lock do
      product.touch :goaled_at unless product.goaled?
      create product: product, created_at: product.goaled_at
    end
  end
end
