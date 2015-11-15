class Admin::ProductsController < AdminController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /admin/products
  def index
    @products = Product.page(params[:page])
  end

  # GET /admin/products/1/edit
  def edit
  end

  # PATCH/PUT /admin/products/1
  def update
    if @product.update(product_params)
      redirect_to [:edit, :seller, @product], notice: 'Product was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update.'
      render :edit
    end
  end

  # DELETE /admin/products/1
  def destroy
    @product.destroy
    redirect_to seller_products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :goal, :closes_on)
  end
end
