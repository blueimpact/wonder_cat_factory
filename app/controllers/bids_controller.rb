class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :create, :destroy]

  # GET /bids
  def index
    @bids = current_user
            .bids
            .includes(product: [:pictures, :bids])
            .newer_first.page(params[:page])
  end

  # GET /products/1/bid
  def show
    @bid = @product.bids.by(current_user).first
    @events = @product.events.for(current_user).includes(bid: [:user])
                      .page(params[:page]).per(Settings.events.count_per_page)
  end

  # POST /products/1/bid
  def create
    @bid = @product.bids.create(user: current_user)
    render :update
  end

  # DELETE /products/1/bid
  def destroy
    @product.bids.by(current_user).destroy_all
    render :update
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
