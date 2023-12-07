FactoryBot.define do
  factory :basket_item do
    basket { nil }
    product { nil }
    amount { 1 }
  end
end
