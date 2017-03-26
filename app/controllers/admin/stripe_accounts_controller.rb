class Admin::StripeAccountsController < ApplicationController
  before_action :set_user, only: [:show, :create]
  before_action :set_stripe_account, only: [:show]

  # GET /admin/users/1/stripe_accounts
  def show
  end

  # POST /admin/users/1/stripe_accounts
  def create
    @account = @user.attach_stripe_account!(request)
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

  def set_stripe_account
    @stripe_account = Stripe::Account.retrieve(
      @user.stripe_account.stripe_user_id
    )
  end

end
