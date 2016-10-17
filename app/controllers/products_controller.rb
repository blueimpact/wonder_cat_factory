class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  # GET /products/1
  def show
    @bid = @product.bids.find_or_initialize_by(user: current_user)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
