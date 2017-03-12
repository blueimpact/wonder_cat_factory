class Admin::SystemMessagesController < ApplicationController
  before_action :set_seller
  before_action :authenticate_user!
  before_action :set_system_message, only: [:show, :edit, :update, :destroy]
  before_action :set_selectable_message_types,
                only: [:new, :create, :edit, :update]

  # GET /admin/system_messages
  def index
    @system_messages = SystemMessage.where(user: @user)
  end

  # GET /admin/system_messages/1
  def show
  end

  # GET /admin/system_messages/new
  def new
    @system_message = @user.system_messages.new
  end

  # GET /admin/system_messages/1/edit
  def edit
  end

  # CREATE /admin/system_messages
  def create
    @system_message = @user.system_messages.new(system_message_params)

    if @system_message.save
      redirect_to admin_user_system_messages_url(@user),
                  notice: 'SystemMessage was successfully created.'
    else
      flash.now[:alert] = 'Failed to create.'
      render :new
    end
  end

  # PATCH/PUT /admin/system_messages/1
  def update
    if @system_message.update(system_message_params)
      redirect_to [:admin, @user, @system_message],
                  notice: 'SystemMessage was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/system_messages/1
  def destroy
    @system_message.destroy
    redirect_to admin_user_system_messages_url(@user),
                notice: 'SystemMessage was successfully destroyed.'
  end

  private

  def set_seller
    @user = User.seller.find(params[:user_id])
  end

  def set_system_message
    @system_message = @user.system_messages.find(params[:id])
  end

  def system_message_params
    params.require(:system_message).permit(:subject, :body, :message_type)
  end

  def set_selectable_message_types
    @selectable_message_types = SystemMessage.message_types.reject do |key|
      @user.system_messages.where.not(
        id: @system_message
      ).map(&:message_type).include?(key)
    end
  end
end
