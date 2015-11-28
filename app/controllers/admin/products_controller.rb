class Admin::ProductsController < AdminController
  # GET /admin/products
  def index
    @products = Product.order(created_at: :desc).page(params[:page])
  end
end
