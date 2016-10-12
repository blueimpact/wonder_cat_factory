class Seller::ProductsController < ProductsController
  include SellerController

  before_action :set_events, only: [:show]

  # GET /seller/products
  def index
    @products = current_user
                .products
                .newer_first
                .page(params[:page])
  end

  private

  def set_product
    @product = current_user.products.find(params[:id])
  end
end
