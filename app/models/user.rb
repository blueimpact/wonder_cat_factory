class User < ActiveRecord::Base
  has_many :products
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
end
