class Seller::EventsController < EventsController
  include SellerController

  before_action :set_bid

  # GET /seller/products/1/events
  # GET /seller/products/1/bids/1/events
  def index
    @events = @product.events.includes(bid: [:user])
                      .page(params[:page]).per(Settings.events.count_per_page)
    @events = @events.for(@bid.user) if @bid
  end
end
