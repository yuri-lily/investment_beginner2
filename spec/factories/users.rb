FactoryBot.define do
  factory :user do
    name                  {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              { 'a1' + Faker::Internet.password(min_length: 4) }
    password_confirmation {password}
    age_id                { '2' }
    gender_id             { '2' }
    profile               { Faker::Lorem.sentence }
  end
end