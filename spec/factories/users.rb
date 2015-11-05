FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@kawaii-plus.com" }
    sequence(:password) { |i| "password#{i}" }
    sequence(:label) { |i| "label_#{i}" }
  end
end
