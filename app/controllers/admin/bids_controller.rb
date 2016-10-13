class Admin::BidsController < BidsController
  include AdminController

  before_action :set_product
  before_action :set_bid, only: [:show]
  before_action :set_events, only: [:show]

  # GET /admin/products/1/bids
  def index
    @bids = @product.bids.older_first.page(params[:page])
  end

  # GET /admin/products/1/bids/1
  def show
    render template: 'admin/products/show'
  end
end
