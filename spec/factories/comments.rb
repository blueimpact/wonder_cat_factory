FactoryGirl.define do
  factory :comment do
    user
    product nil
    sequence(:body) { |i| "Comment #{i}" }
  end
end
