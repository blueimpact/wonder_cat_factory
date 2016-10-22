FactoryGirl.define do
  factory :picture do
    product nil
    image File.new(Rails.root.join('spec/fixtures/image.jpg'))

    trait :without_image do
      image nil
    end
  end
end
