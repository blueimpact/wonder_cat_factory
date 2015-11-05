FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@kawaii-plus.com" }
    sequence(:password) { |i| "password#{i}" }
    sequence(:label) { |i| "label_#{i}" }

    trait :admin do
      is_admin true
    end

    trait :seller do
      is_seller true
    end
  end

  trait :with_user do
    user
  end
end
