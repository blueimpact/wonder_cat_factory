class Manage::ProductMessagesController < ApplicationController
  before_action :set_manage_product_message, only: [:show, :edit, :update, :destroy]

  # GET /manage/product_messages
  def index
    @manage_product_messages = Manage::ProductMessage.all
  end

  # GET /manage/product_messages/1
  def show
  end

  # GET /manage/product_messages/new
  def new
    @manage_product_message = Manage::ProductMessage.new
  end

  # GET /manage/product_messages/1/edit
  def edit
  end

  # POST /manage/product_messages
  def create
    @manage_product_message = Manage::ProductMessage.new(manage_product_message_params)

    if @manage_product_message.save
      redirect_to @manage_product_message, notice: 'Product message was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /manage/product_messages/1
  def update
    if @manage_product_message.update(manage_product_message_params)
      redirect_to @manage_product_message, notice: 'Product message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /manage/product_messages/1
  def destroy
    @manage_product_message.destroy
    redirect_to manage_product_messages_url, notice: 'Product message was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manage_product_message
      @manage_product_message = Manage::ProductMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def manage_product_message_params
      params[:manage_product_message]
    end
end
