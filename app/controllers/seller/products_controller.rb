class Seller::ProductsController < ApplicationController
  # GET /seller/products
  def index
    @products =
      current_user.products
      .order(created_at: :desc)
      .page(params[:page])
  end
end
