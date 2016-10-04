class Seller::BidsController < BidsController
  include SellerController

  before_action :set_product, only: [:index]

  # GET /products/1/bids
  def index
    authorize! :manage, @product
    @bids = @product.bids.older_first.page(params[:page])
  end
end
