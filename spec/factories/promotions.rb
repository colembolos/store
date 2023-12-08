FactoryBot.define do
  factory :promotion do
    product { nil }
    promotion_type { 1 }
    threshold { 1 }
    rules { "" }
  end
end
