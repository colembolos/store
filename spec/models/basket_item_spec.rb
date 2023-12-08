require 'rails_helper'

RSpec.describe BasketItem, type: :model do
  describe "Relationships" do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:basket) }
  end

  describe '#price_value' do
    it 'does convert product price from integer to a float' do
      product = create(:product, price: 2000)
      basket_item = create(:basket_item, product: product)

      expect(basket_item.price_value).to eq(20.00)
    end
  end

end
