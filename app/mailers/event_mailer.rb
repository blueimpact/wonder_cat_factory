class EventMailer < ApplicationMailer
  def to_user event, bid
    @event = event
    @product = event.product
    @bid = bid
    @user = bid.user
    @product_message = @product.product_messages.send(
      event.class.model_name.element
    ).first

    subject = @product_message ? @product_message.subject : default_i18n_subject

    mail to: @user.email, subject: subject
  end

  def to_seller event
    @event = event
    @product = event.product
    @user = event.product.user
    @system_message = @user.system_messages.send(
      event.class.model_name.element
    ).first

    subject = @system_message ? @system_message.subject : default_i18n_subject

    mail to: @user.email, subject: subject
  end
end
