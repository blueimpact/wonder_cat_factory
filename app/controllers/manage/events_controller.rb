class Manage::EventsController < ApplicationController
  before_action :set_product
  before_action :set_bid

  # GET /admin/products/1/events
  # GET /admin/products/1/bids/1/events
  # GET /seller/products/1/events
  # GET /seller/products/1/bids/1/events
  def index
    @events = @product.events
                      .includes(bid: [:user])
                      .page(params[:page]).per(Settings.events.count_per_page)
    @events = @events.for(@bid.user) if @bid
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_bid
    @bid = params[:bid_id].presence && @product.bids.find(params[:bid_id])
  end
end
