FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    password { "password" }

    trait :admin do
      role { 1 }
    end
  end
end
