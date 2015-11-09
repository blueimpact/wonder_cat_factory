class User < ActiveRecord::Base
  has_many :products, dependent: :destroy
  has_many :bids, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :admin, -> { where(is_admin: true) }
  scope :seller, -> { where(is_seller: true) }

  def admin?
    is_admin?
  end

  def seller?
    is_seller?
  end

  def bid product
    bids.create(product: product)
  end

  def bidded? product
    @bidded_product_ids ||= bids.pluck(:product_id)
    @bidded_product_ids.include? product.id
  end
end
