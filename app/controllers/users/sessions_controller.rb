class Users::SessionsController < ApplicationController
  # GET /users/sign_in
  def new
    if signed_in?
      redirect_to after_sign_in_path_for(current_user)
    else
      @user = User.new
    end
  end

  # POST /users/sign_in
  def create
    @user = User.find_or_initialize_by(user_params)
    if @user.new_record?
      confirm
    else
      reconfirm
    end
    render :new
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def confirm
    @user.update! password: Devise.friendly_token, label: @user.email[/[^@]+/]
    flash.now[:notice] =
      I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end

  def reconfirm
    @user.update! unconfirmed_email: @user.email
    @user.send_reconfirmation_instructions
    flash.now[:notice] = I18n.t('devise.confirmations.send_instructions')
  end
end
