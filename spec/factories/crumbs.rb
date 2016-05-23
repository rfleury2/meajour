FactoryGirl.define do
  factory :crumb do
    measurement Random.rand(1..100.0)
    record_date DateTime.now
    association :track, factory: :tracks
  end
end