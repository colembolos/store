FactoryBot.define do
  factory :basket_item do
    basket
    product
    amount { 1 }
  end
end
