FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    code { Faker::Name.unique.initials }
    price { 1000 }
  end
end
