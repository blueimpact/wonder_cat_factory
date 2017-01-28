class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :create, :destroy, :charge]
  before_action :verify_bid_by_current_user, only: [:charge]
  before_action :create_stripe_customer, only: [:charge]

  # GET /bids
  def index
    @bids = current_user
            .bids
            .includes(product: [:pictures, :bids])
            .updated_first.page(params[:page])
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
    @product.bids.by(current_user).unpaid.destroy_all
    redirect_to @product, notice: 'Bid was successfully destroyed.'
  end

  # POST /products/1/bid/charge
  def charge
    @product.purchased_by(@stripe_customer.id)

    current_user.update_purchased(@product)
    redirect_to :back, notice: 'Product was successfully purchased.'

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to :back
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def verify_bid_by_current_user
    message = 'User does not bid yet.' unless current_user.bidded?(@product)

    message = 'User already charged.' if @product.paid_by?(current_user)

    redirect_to :back, alert: message if message
  end

  def create_stripe_customer
    @stripe_customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )
  end
end
