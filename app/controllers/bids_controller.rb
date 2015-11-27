class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create, :destroy]

  # GET /products/1/bids
  def index
    @bids = @product.bids.order(created_at: :desc).page(params[:page])
  end

  # POST /products/1/bid
  def create
    @product.bids.create(user: current_user)
    render :update
  end

  # DELETE /products/1/bid
  def destroy
    @product.bids.where(user: current_user).destroy_all
    render :update
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
