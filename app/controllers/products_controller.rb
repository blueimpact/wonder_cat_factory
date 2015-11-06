class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  # GET /products
  def index
    @products =
      Product.active
      .order(closes_on: :asc)
      .includes(:pictures)
      .page(params[:page])
  end

  # GET /products/1
  def show
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
