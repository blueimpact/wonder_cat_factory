class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  # GET /products/1
  def show
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
