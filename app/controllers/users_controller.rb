class UsersController < ApplicationController
  def available
    @user = User.new(user_params)
    @user.valid?(params[:context].try(:to_sym))
    @errors = {}
    user_params.keys.each do |k|
      @errors[k] = @user.errors.full_messages_for(k.to_sym)
    end
    render json: @errors.to_json
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:username, :email, :password, :label, :birthday,
              :is_admin, :is_seller)
  end
end
