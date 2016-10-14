class EventsController < ApplicationController
  before_action :set_product
  before_action :set_bid

  # GET /products/1/bid/events
  def index
    @events = @product.events.for(current_user).includes(bid: [:user])
                      .page(params[:page]).per(Settings.events.count_per_page)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_bid
    @bid = @product.bids.by(current_user).first
  end
end
