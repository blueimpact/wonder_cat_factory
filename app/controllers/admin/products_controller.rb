class Admin::ProductsController < AdminController
  before_action :set_user
  load_and_authorize_resource :product, only: [:show]

  # GET /admin/products
  # GET /admin/users/1/products
  def index
    @products = (@user.try(:products) || Product)
                .order(created_at: :desc)
                .page(params[:page])
  end

  # GET /admin/products/1
  def show
  end

  private

  def set_user
    @user = params[:user_id] && User.find(params[:user_id])
  end
end
