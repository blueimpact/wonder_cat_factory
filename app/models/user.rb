class User < ActiveRecord::Base
  has_many :products, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_one :stripe_account

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  scope :admin, -> { where(is_admin: true) }
  scope :seller, -> { where(is_seller: true) }

  def to_s
    label.presence || email
  end

  def admin?
    is_admin?
  end

  def seller?
    is_seller?
  end

  def age
    birthday.present? ? Time.current.year - birthday.year : nil
  end

  def bid product
    bids.create(product: product)
  end

  def bidded? product
    @bidded_product_ids ||= bids.pluck(:product_id)
    @bidded_product_ids.include? product.id
  end
end
