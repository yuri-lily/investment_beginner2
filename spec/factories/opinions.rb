FactoryBot.define do
  factory :opinion do
    brand           {'aaaa'}
    privacy_id      {'2'}
    theory          {Faker::Lorem.sentence}
    association :user
  end
end