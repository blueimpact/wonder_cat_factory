class Manage::ProductMessagesController < ApplicationController
  before_action :set_product
  before_action :set_product_message, only: [:edit, :update, :destroy]
  before_action :set_selectable_message_types,
                only: [:new, :create, :edit, :update]

  # GET /admin/products/1/product_messages
  # GET /seller/products/1/product_messages
  def index
    @product_messages = @product.product_messages.order(message_type: :asc)
  end

  # GET /admin/products/1/product_messages/new
  # GET /seller/products/1/product_messages/new
  def new
    @product_message = @product.product_messages.new(
      subject: t('event_mailer.to_user.subject'),
      body: t('event_mailer.to_user.body')
    )
  end

  # GET /admin/products/1/product_messages/new
  # GET /seller/products/1/product_messages/new
  def edit
  end

  # POST /admin/products/product_messages
  # POST /seller/products/product_messages
  def create
    @product_message = @product.product_messages.new(product_message_params)

    if @product_message.save
      redirect_to [current_role, @product, :product_messages],
                  notice: 'Product message was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/products/1/product_messages/1
  # PATCH/PUT /seller/products/1/product_messages/1
  def update
    if @product_message.update(product_message_params)
      redirect_to [current_role, @product, :product_messages],
                  notice: 'Product message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/products/1/product_messages/1
  # DELETE /seller/products/1/product_messages/1
  def destroy
    @product_message.destroy
    redirect_to [current_role, @product, :product_messages],
                notice: 'Product message was successfully updated.'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_product_message
    @product_message = @product.product_messages.find(params[:id])
  end

  def product_message_params
    params.require(:product_message).permit(:subject, :body, :message_type)
  end

  def set_selectable_message_types
    @selectable_message_types = ProductMessage.message_types.reject do |key|
      @product.product_messages.where.not(
        id: @product_message
      ).map(&:message_type).include?(key)
    end
  end
end
