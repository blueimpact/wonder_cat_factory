class ProductsController < ApplicationController
  before_action :authenticate_user!
  load_resource :user, only: [:index]
  load_and_authorize_resource :product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    @products = Product
                .ready
                .bidden_by(current_user)
                .order(closes_on: :asc)
                .includes(:pictures, :user)
                .page(params[:page])
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to [:edit, role, @product], notice: 'Product was created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to [:edit, role, @product], notice: 'Product was updated.'
    else
      flash.now[:alert] = 'Failed to update.'
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to [role, :products], notice: 'Product was destroyed.'
  end

  private

  def product_params
    params
      .require(:product)
      .permit(:title, :description, :price, :goal, :closes_on, :external_url)
  end
end
