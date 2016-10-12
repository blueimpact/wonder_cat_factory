class Seller::BidsController < BidsController
  include SellerController

  before_action :set_product, only: [:index, :show]

  # GET /seller/products/1/bids
  def index
    @bids = @product.bids.older_first.page(params[:page])
  end

  # GET /seller/products/1/bids/1
  def show
    @bid = @product.bids.find(params[:id])
    @events = @product.events.for(@bid.user).page
    render template: 'seller/products/show'
  end

  private

  def set_product
    @product = current_user.products.find(params[:product_id])
  end
end
