class Users::ConfirmationsController < ApplicationController
  include Devise::Controllers::Rememberable

  before_action :set_user

  # GET /users/confirmation?confirmation_token=abcdef
  def show
    if updating_email?
      update_email
    else
      confirm
    end
  end

  private

  def set_user
    @user = User.find_by(confirmation_token: params[:confirmation_token])
  end

  def updating_email?
    user = @user || current_user
    user &&
      user.confirmed? &&
      user.pending_reconfirmation? &&
      (user.email != user.unconfirmed_email)
  end

  def update_email
    if confirm_and_sign_in @user
      redirect_to [:edit, :user, :registration],
                  notice: I18n.t('devise.registrations.updated')
    elsif signed_in?
      flash.now[:alert] = I18n.t('devise.failure.unconfirmed') unless @user
      @user ||= current_user
      render template: 'users/registrations/edit'
    else
      redirect_to [:edit, :user, :registration]
    end
  end

  def confirm
    if confirm_and_sign_in(@user) || signed_in?
      redirect_to after_sign_in_path_for(@user || current_user)
    else
      flash.now[:alert] = I18n.t('devise.failure.unconfirmed') unless @user
      @user ||= User.new
      render template: 'users/sessions/new'
    end
  end

  def confirm_and_sign_in user
    if user.try(:confirm)
      sign_in user
      remember_me user
      user.update! confirmation_token: nil
      true
    else
      false
    end
  end
end
