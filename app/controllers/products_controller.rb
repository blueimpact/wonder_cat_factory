class ProductsController < ApplicationController
  load_resource :user, only: [:index, :bidden]
  load_and_authorize_resource :product, only: [:show, :edit, :update, :destroy]

  # GET /products/bidden
  def bidden
    index
    @products = @products.bidden_by(current_user)
    render :index
  end

  # GET /products
  def index
    @products = (@user.try(:products) || Product)
                .ready
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
      redirect_to [:edit, @product], notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to [:edit, @product], notice: 'Product was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update.'
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product)
          .permit(:title, :description, :price, :goal, :closes_on)
  end
end
