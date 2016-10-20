class EventMailerPreview < ActionMailer::Preview
  def to_user_goaled
    event = Events::GoaledEvent.last
    EventMailer.to_user event, event.product.bids.last
  end

  def to_user_enqueued
    event = Events::EnqueuedEvent.last
    EventMailer.to_user event, event.bid
  end

  def to_user_dequeued
    event = Events::DequeuedEvent.last
    EventMailer.to_user event, event.bid
  end

  def to_seller_started
    event = Events::StartedEvent.last
    EventMailer.to_seller event
  end

  def to_seller_goaled
    event = Events::GoaledEvent.last
    EventMailer.to_seller event
  end

  def to_seller_enqueued
    event = Events::EnqueuedEvent.last
    EventMailer.to_seller event
  end
end
