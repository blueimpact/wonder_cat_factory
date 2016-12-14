class Admin::StripeAccountsController < ApplicationController
  before_action :set_user, only: [:create]

  # POST /admin/users/1/stripe_accounts
  def create
    @account = @user.attach_stripe_account!
    redirect_to [:admin, @user], notice: 'Stripe account created!'
  rescue Stripe::InvalidRequestError => err
    redirect_to [:admin, @user], alert: err.message
  rescue ActiveRecord::ActiveRecordError => err
    redirect_to [:admin, @user], alert: err.message
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
