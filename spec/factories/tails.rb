FactoryGirl.define do
  factory :tail do
    name Faker::Name.title
    user { build(:user) }
  end
end