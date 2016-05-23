FactoryGirl.define do
  factory :track do
    name Faker::Name.title
    association :user, factory: :user
  end
end