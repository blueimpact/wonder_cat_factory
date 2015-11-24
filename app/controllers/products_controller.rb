class ProductsController < ApplicationController
  before_action :set_user, only: [:index]
  before_action :set_product, only: [:show]

  # GET /products
  def index
    @products =
      (@user.try(:products) || Product).ready
      .order(closes_on: :asc)
      .includes(:pictures, :user)
      .page(params[:page])

    if @bidden = current_user && params[:bidden].presence
      @products = @products.bidden_by(current_user)
    end
  end

  # GET /products/1
  def show
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
