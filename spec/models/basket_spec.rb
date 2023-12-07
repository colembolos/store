require 'rails_helper'

RSpec.describe Basket, type: :model do
  describe '#total' do
    it 'calculates the total price of all items in the basket' do
      basket = create(:basket)
      product1 = create(:product, price: 1500)
      product2 = create(:product, price: 1000)
      create(:basket_item, basket: basket, product: product1, amount: 3)
      create(:basket_item, basket: basket, product: product2, amount: 2)

      expect(basket.total).to eq 6500
    end
  end
end
