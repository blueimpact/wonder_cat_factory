class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :create, :destroy, :charge]

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
    @product.bids.by(current_user).destroy_all
    redirect_to @product, notice: 'Bid was successfully destroyed.'
  end

  # POST /products/1/bid/charge
  def charge
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    @product.pay(customer.id)

    redirect_to :back

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to :back
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
