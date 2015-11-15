FactoryGirl.define do
  factory :comment do
    user nil
    product nil
    sequence(:body) { |i|  "Comment #{i}" }
  end
end
