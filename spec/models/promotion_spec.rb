require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe "Relationships" do
    it { is_expected.to belong_to(:product) }
  end

  describe "#apply" do
    context "when the promotion is type of get_one_free" do
      let(:basket) { create(:basket) }
      let(:product) { create(:product, price: 1500) }
      let!(:basket_items) { create_list(:basket_item, 2, basket: basket, product: product) }
      let(:promotion) { create(:promotion, product: product, promotion_type: :get_one_free, threshold: 2) }

      it "does apply the promotion type" do
        expect(promotion.apply(basket.grouped_items.first)).to eq(1500)
      end

      context "when cannot apply the promotion" do
        let(:promotion) { create(:promotion, product: product, promotion_type: :get_one_free, threshold: 3) }

        it "does not apply the promotion type" do
          expect(promotion.apply(basket.grouped_items.first)).to eq(3000)
        end
      end
    end

    context "when the promotion is type of bulk_discount" do
      let(:basket) { create(:basket) }
      let(:product) { create(:product, price: 1500) }
      let!(:basket_items) { create_list(:basket_item, 3, basket: basket, product: product) }
      let(:promotion) { create(:promotion, product: product, promotion_type: :bulk_discount, threshold: 3, rules: { discounted_price: 1000 }) }

      it "does apply the promotion type" do
        expect(promotion.apply(basket.grouped_items.first)).to eq(3000)
      end

      context "when cannot apply the promotion" do
        let(:promotion) { create(:promotion, product: product, promotion_type: :get_one_free, threshold: 4) }

        it "does not apply the promotion type" do
          expect(promotion.apply(basket.grouped_items.first)).to eq(4500)
        end
      end
    end

    context "when the promotion is type of bulk_percentage" do
      let(:basket) { create(:basket) }
      let(:product) { create(:product, price: 1000) }
      let!(:basket_items) { create_list(:basket_item, 3, basket: basket, product: product) }
      let(:promotion) { create(:promotion, product: product, promotion_type: :bulk_percentage, threshold: 3, rules: { discount_percentage: 5000 }) }

      it "does apply the promotion type" do
        expect(promotion.apply(basket.grouped_items.first)).to eq(1500)
      end

      context "when cannot apply the promotion" do
        let(:promotion) { create(:promotion, product: product, promotion_type: :get_one_free, threshold: 4) }

        it "does not apply the promotion type" do
          expect(promotion.apply(basket.grouped_items.first)).to eq(3000)
        end
      end
    end
  end
end
