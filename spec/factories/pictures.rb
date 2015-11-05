FactoryGirl.define do
  factory :picture do
    product nil
    image nil

    trait :with_image do
      image File.new(Rails.root.join('spec/fixtures/image.jpg'))
    end
  end
end
