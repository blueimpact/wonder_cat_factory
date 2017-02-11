class Admin::SystemMessagesController < ApplicationController
  before_action :set_seller
  before_action :set_system_message, only: [:show, :edit, :update]
  before_action :authenticate_user!

  # GET /admin/system_messages
  def index
    @system_messages = SystemMessage.where(user: @user)
  end

  # GET /admin/system_messages/1
  def show
  end

  # GET /admin/system_messages/1/edit
  def edit
  end

  # PATCH/PUT /admin/system_messages/1
  def update
    if @system_message.update(system_message_params)
      redirect_to [:admin, @user, @system_message],
                  notice: 'System message was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_seller
    @user = User.seller.find(params[:user_id])
  end

  def set_system_message
    @system_message = @user.system_messages.find(params[:id])
  end

  def system_message_params
    params.require(:system_message).permit(:title, :body)
  end
end
