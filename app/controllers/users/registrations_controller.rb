class Users::RegistrationsController < ApplicationController
  before_action :authenticate_user!

  # GET /users/edit
  def edit
    @user = current_user
  end

  # PUT /users
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    @user = current_user
    @user.update! user_params
    if @user.previous_changes.key? :confirmation_sent_at
      flash[:notice] = I18n.t('devise.registrations.update_needs_confirmation')
    else
      flash[:notice] = I18n.t('devise.registrations.updated')
    end
    redirect_to [:edit, :user, :registration]
  rescue
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:email, :label, :birthday)
  end
end
