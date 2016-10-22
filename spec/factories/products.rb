FactoryGirl.define do
  factory :product do
    user
    sequence(:title) { |i| "Product #{i}" }
    sequence(:description) { |i| "Description #{i}" }
    price 10_000
    goal 100
    sequence(:closes_on) { |i| 1.month.since + i.day }
    bids_count 0

    trait :started do
      pictures_count 1
      started_at 5.days.ago
    end

    trait :goaled do
      goaled_at 2.days.ago
    end

    transient do
      pictures_count 0
    end

    trait :with_one_picture do
      pictures_count 1
    end

    trait :with_some_pictures do
      pictures_count 2
    end

    after(:build) do |product, evaluator|
      if evaluator.pictures_count > 0
        product.pictures = build_list(:picture, evaluator.pictures_count)
      end
    end
  end

  trait :with_product do
    association :product, factory: :product
  end
end
