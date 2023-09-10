FactoryBot.define do
  factory :favorite do
    symbol             {'aaaa'}
    registered_price   {'100.00'}
    price              {'100.00'}
    association :user
  end
end
