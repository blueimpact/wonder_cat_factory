FactoryGirl.define do
  factory :system_message do
    user
    sequence(:subject) { |i| "SystemMessage subject #{i}" }
    sequence(:body) { |i| "SystemMessage Body #{i}" }
    message_type :started_event
  end
end
