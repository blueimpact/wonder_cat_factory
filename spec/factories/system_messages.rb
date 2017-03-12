FactoryGirl.define do
  factory :system_message do
    user
    sequence(:subject) { |i| "SystemMessage subject #{i}" }
    sequence(:body) { |i| "SystemMessage Body #{i}" }
    sequence(:message_type, %i(started_event enqueued_event goaled_event).cycle)
  end
end
