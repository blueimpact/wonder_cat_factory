class Seller::BidsController < BidsController
  include SellerController

  before_action :set_product
  before_action :set_bid, only: [:show]
  before_action :set_events, only: [:show]

  # GET /seller/products/1/bids
  def index
    @bids = @product.bids.older_first.page(params[:page])
  end

  # GET /seller/products/1/bids/1
  def show
    render template: 'manage/products/show'
  end

  private

  def set_product
    @product = current_user.products.find(params[:product_id])
  end
end
