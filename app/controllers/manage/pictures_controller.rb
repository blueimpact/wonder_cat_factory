class Manage::PicturesController < ApplicationController
  before_action :set_product
  before_action :set_picture, only: [:destroy]

  # POST /products/1/pictures
  def create
    @picture = Picture.create!(picture_params.merge(product: @product))
  end

  # DELETE /products/1/pictures/1
  def destroy
    @picture.destroy!
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_picture
    @picture = @product.pictures.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image)
  end
end
