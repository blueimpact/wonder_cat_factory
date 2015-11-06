FactoryGirl.define do
  factory :product do
    user nil
    sequence(:title) { |i| "Product #{i}" }
    sequence(:description) { |i| "Description #{i}" }
    price 10000
    goal 100
    sequence(:closes_on) { |i| 1.month.since + i }
    bids_count 0
  end

  trait :with_product do
    association :product, :with_user, factory: :product
  end
end
