class Seller::EventsController < Manage::EventsController
  include SellerController

  private

  def set_product
    @product = current_user.products.find(params[:product_id])
  end
end
