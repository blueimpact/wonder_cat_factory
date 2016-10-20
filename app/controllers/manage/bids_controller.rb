class Manage::BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :set_bid, only: [:show]
  before_action :set_events, only: [:show]

  # GET /admin/products/1/bids
  # GET /seller/products/1/bids
  def index
    @bids = @product.bids.older_first.page(params[:page])
  end

  # GET /admin/products/1/bids/1
  # GET /seller/products/1/bids/1
  def show
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_bid
    @bid = @product.bids.find(params[:id])
  end

  def set_events
    @events = @product.events.for(@bid.user).includes(bid: [:user])
                      .page.per(Settings.events.count_per_page)
  end
end
