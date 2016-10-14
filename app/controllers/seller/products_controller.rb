class Seller::ProductsController < Manage::ProductsController
  include SellerController

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
