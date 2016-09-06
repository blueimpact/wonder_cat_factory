class PicturesController < ApplicationController
  load_and_authorize_resource :product
  before_action :set_picture, only: [:destroy]

  # POST /products/1/pictures
  def create
    @picture = Picture.new(picture_params)
    @picture.product = @product

    if @picture.save
      redirect_to [:edit, role, @product], notice: 'Picture was created.'
    else
      redirect_to [:edit, role, @product], alert: 'Failed to create Picture.'
    end
  end

  # DELETE /products/1/pictures/1
  def destroy
    @picture.destroy
    redirect_to [:edit, role, @product], notice: 'Picture was destroyed.'
  end

  private

  def set_picture
    @picture = @product.pictures.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image)
  end
end
