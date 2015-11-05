FactoryGirl.define do
  factory :product do
    user nil
    sequence(:title) { |i| "Product #{i}" }
    sequence(:description) { |i| "Description #{i}" }
    price 10000
    goal 100
    closes_on "2015-11-05"
    bids_count 0
  end

  trait :with_product do
    association :product, :with_user, factory: :product
  end
end
