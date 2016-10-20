class EventMailer < ApplicationMailer
  def to_user event, bid
    @event = event
    @product = event.product
    @bid = bid
    @user = bid.user
    mail to: @user.email, subject: event.to_message(:short)
  end

  def to_seller event
    @event = event
    @product = event.product
    @user = event.product.user
    mail to: @user.email, subject: event.to_message(:short)
  end
end
