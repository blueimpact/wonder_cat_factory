class Manage::ProductMessagesController < ApplicationController
  before_action :set_product
  before_action :set_product_message, only: [:edit, :update]

  # GET /admin/products/1/product_messages
  # GET /seller/products/1/product_messages
  def index
    @product_messages = ProductMessage.order(message_type: :asc)
  end

  # GET /admin/products/1/product_messages/1/edit
  # GET /seller/products/1/product_messages/1/edit
  def edit
  end

  # PATCH/PUT /admin/products/1/product_messages/1
  # PATCH/PUT /seller/products/1/product_messages/1
  def update
    if @product_message.update(product_message_params)
      redirect_to [current_role, @product, :product_messages],
                  notice: 'Instruction was successfully updated.'
    else
      render :edit
    end
  end

  private

    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_product_message
      @product_message = ProductMessage.find(params[:id])
    end

    def product_message_params
      params.require(:product_message).permit(:subject, :body)
    end
end
