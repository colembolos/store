require 'rails_helper'

RSpec.describe Basket, type: :model do
  describe "Relationships" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:basket_items) }
    it { is_expected.to have_many(:products) }
  end

  describe '#total' do
    it 'calculates the total price of all items in the basket' do
      basket = create(:basket)
      product1 = create(:product, price: 1500)
      product2 = create(:product, price: 1000)
      create_list(:basket_item, 3, basket: basket, product: product1)
      create_list(:basket_item, 2, basket: basket, product: product2)

      expect(basket.total).to eq 6500
    end
  end
end
