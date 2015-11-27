class ProductsController < ApplicationController
  before_action :set_user, only: [:index, :bidden]
  before_action :set_product, only: [:show]

  # GET /products
  def index
    @products =
      (@user.try(:products) || Product).ready
      .order(closes_on: :asc)
      .includes(:pictures, :user)
      .page(params[:page])
  end

  # GET /products/1
  def show
  end

  # GET /products/bidden
  def bidden
    index
    @products = @products.bidden_by(current_user)
    render :index
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
