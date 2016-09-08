class Seller::ProductsController < ProductsController
  include SellerController

  # GET /seller/products
  def index
    @products = current_user
                .products
                .newer_first
                .page(params[:page])
  end
end
