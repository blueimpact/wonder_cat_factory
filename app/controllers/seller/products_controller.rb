class Seller::ProductsController < SellerController
  load_and_authorize_resource :product, only: [:show]

  # GET /seller/products
  def index
    @products = current_user
                .products
                .order(created_at: :desc)
                .page(params[:page])
  end

  # GET /seller/products/1
  def show
  end
end
