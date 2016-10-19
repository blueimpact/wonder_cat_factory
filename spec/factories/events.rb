FactoryGirl.define do
  factory :started_event, class: 'Events::StartedEvent' do
  end

  factory :goaled_event, class: 'Events::GoaledEvent' do
  end

  factory :enqueued_event, class: 'Events::EnqueuedEvent' do
  end

  factory :dequeued_event, class: 'Events::DequeuedEvent' do
  end
end
