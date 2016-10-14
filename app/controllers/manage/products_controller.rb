class Manage::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_events, only: [:show]

  # GET /admin/products/1
  # GET /seller/products/1
  def show
  end

  # GET /admin/products/new
  # GET /seller/products/new
  def new
    @product = Product.new
  end

  # GET /admin/products/1/edit
  # GET /seller/products/1/edit
  def edit
  end

  # POST /admin/products
  # POST /seller/products
  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to [:edit, current_role, @product],
                  notice: 'Product was created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/products/1
  # PATCH/PUT /seller/products/1
  def update
    if @product.update(product_params)
      redirect_to [:edit, current_role, @product],
                  notice: 'Product was updated.'
    else
      flash.now[:alert] = 'Failed to update.'
      render :edit
    end
  end

  # DELETE /admin/products/1
  # DELETE /seller/products/1
  def destroy
    @product.destroy
    redirect_to [current_role, :products],
                notice: 'Product was destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_events
    @events = @product.events.includes(bid: [:user])
                      .page.per(Settings.events.count_per_page)
  end

  def product_params
    params
      .require(:product)
      .permit(:title, :description, :price, :goal, :closes_on, :external_url)
  end
end
