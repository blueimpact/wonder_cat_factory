FactoryGirl.define do
  factory :product do
    user nil
    sequence(:title) { |i| "Product #{i}" }
    sequence(:description) { |i| "Description #{i}" }
    price 10000
    goal 100
    sequence(:closes_on) { |i| 1.month.since + i }
    bids_count 0

    transient do
      pictures_count 0
    end

    trait :with_one_picture do
      pictures_count 1
    end

    trait :with_some_pictures do
      pictures_count 2
    end

    after(:create) do |product, evaluator|
      if evaluator.pictures_count > 0
        product.pictures = build_list(:picture, evaluator.pictures_count, :with_image)
      end
    end
  end

  trait :with_product do
    association :product, :with_user, factory: :product
  end
end
