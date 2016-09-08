class Admin::ProductsController < ProductsController
  include AdminController

  # GET /admin/products
  # GET /admin/users/1/products
  def index
    @products = (@user.try(:products) || Product)
                .newer_first
                .page(params[:page])
  end
end
