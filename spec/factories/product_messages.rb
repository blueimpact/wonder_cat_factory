FactoryGirl.define do
  factory :product_message do
    product
    sequence(:subject) { |i| "ProductMessage subject #{i}" }
    sequence(:body) { |i| "ProductMessage Body #{i}" }
    sequence(
      :message_type, %i(enqueued_event goaled_event dequeued_event).cycle
    )
  end
end
