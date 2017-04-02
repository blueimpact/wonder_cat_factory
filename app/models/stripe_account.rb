class StripeAccount < ActiveRecord::Base
  belongs_to :user

  def retrieve
    Stripe::Account.retrieve(stripe_user_id)
  end
end
