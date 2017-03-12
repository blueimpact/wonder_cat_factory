FactoryGirl.define do
  factory :product_message do
    product
    sequence(:subject) { |i| "SystemMessage subject #{i}" }
    sequence(:body) { |i| "SystemMessage Body #{i}" }
    message_type :enqueued_event
  end
end
