class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :create, :destroy, :charge]
  before_action :verify_bid_by_current_user, only: [:charge]

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
    @product.bids.by(current_user).not_paid.destroy_all
    redirect_to @product, notice: 'Bid was successfully destroyed.'
  end

  # POST /products/1/bid/charge
  def charge
    @stripe_customer = set_stripe_customer

    @product.pay(@stripe_customer.id)
    @product.bids.by(current_user).update_all paid_at: Time.current
    redirect_to :back

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to :back
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def verify_bid_by_current_user
    if !current_user.bidded?(@product)
      raise 'User does not bid product yet.'
    end

    if !current_user.paid?(@product)
      raise 'User already charged.'
    end
  end

  def set_stripe_customer
    Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )
  end
end
