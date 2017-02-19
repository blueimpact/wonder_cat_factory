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
    @system_message = @user.system_messages.send(
      event.class.model_name.element
    ).first

    mail to: @user.email, subject: @system_message.subject
  end
end
