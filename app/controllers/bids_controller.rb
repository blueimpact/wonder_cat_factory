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
    @bid = @product.bids.find_by(user: current_user)
    @events = @product.events.for(current_user).page
  end

  # POST /products/1/bid
  def create
    @bid = @product.bids.create(user: current_user)
    Events::EnqueuedEvent.trigger @bid
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
end
