FactoryGirl.define do
  factory :product_message do
    subject "MyString"
    body "MyText"
    product nil
    message_type 1
  end
end
