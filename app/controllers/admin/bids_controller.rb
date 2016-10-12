class Admin::BidsController < BidsController
  include AdminController

  before_action :set_product, only: [:index, :show]

  # GET /admin/products/1/bids
  def index
    @bids = @product.bids.older_first.page(params[:page])
  end

  # GET /admin/products/1/bids/1
  def show
    @bid = @product.bids.find(params[:id])
    @events = @bid.events.page
    render template: 'admin/products/show'
  end
end
