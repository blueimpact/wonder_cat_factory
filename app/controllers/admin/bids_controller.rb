class Admin::BidsController < BidsController
  include AdminController

  before_action :set_product, only: [:index]

  # GET /products/1/bids
  def index
    @bids = @product.bids.older_first.page(params[:page])
  end
end
