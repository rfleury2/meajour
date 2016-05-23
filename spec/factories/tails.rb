FactoryGirl.define do
  factory :tail do
    name Faker::Name.title
    association :user, factory: :user
  end
end