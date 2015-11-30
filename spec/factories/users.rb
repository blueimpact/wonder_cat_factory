FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@kawaii-plus.com" }
    sequence(:password) { |i| "password#{i}" }
    sequence(:label) { |i| "label_#{i}" }

    transient do
      confirmed? true
    end

    trait :unconfirmed do
      confirmed? false
    end

    trait :admin do
      is_admin true
    end

    trait :seller do
      is_seller true
    end

    before(:create) do |user, evaluator|
      evaluator.confirmed? && user.skip_confirmation!
    end
  end

  trait :with_user do
    user
  end

  trait :without_user do
    user nil
  end
end
