FactoryGirl.define do
  factory :system_message do
    user
    sequence(:title) { |i| "SystemMessage title #{i}" }
    sequence(:body) { |i| "SystemMessage Body #{i}" }
    message_type :started
  end
end
