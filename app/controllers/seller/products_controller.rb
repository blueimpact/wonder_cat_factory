class Seller::ProductsController < ProductsController
  include SellerController

  # GET /seller/products
  def index
    @products = current_user
                .products
                .order(created_at: :desc)
                .page(params[:page])
  end
end
