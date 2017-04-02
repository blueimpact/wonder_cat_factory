class Admin::StripeAccountsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :create]
  before_action :set_stripe_object, only: [:show, :edit]

  # GET /admin/users/1/stripe_accounts
  def show
  end

  # GET /admin/users/1/stripe_accounts/edit
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

  def update
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_stripe_object
    @stripe_object = @user.stripe_account.retrieve
  end

end
