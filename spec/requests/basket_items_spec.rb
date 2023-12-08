require 'rails_helper'

RSpec.describe "BasketItems", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /index" do
    let(:basket) { create(:basket, user: user) }
    let(:product) { create(:product, code: "Test Product") }
    let!(:basket_item) { create(:basket_item, basket: basket, product: product) }

    it "returns http success" do
      get basket_items_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Test Product")
    end
  end

  describe "POST /create" do
    let(:product) { create(:product) }
    let(:basket) { create(:basket, user: user) }

    it "creates a new basket item" do
      expect {
        post basket_items_path, params: { product_id: product.id }
      }.to change(BasketItem, :count).by(1)
      expect(response).to redirect_to(products_path)
    end

    context "when the product parameter is missing" do
      it "returns an error" do
        expect {
          post basket_items_path, params: {}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "DELETE /destroy" do
    let(:basket) { create(:basket, user: user) }
    let(:basket_item) { create(:basket_item, basket: basket) }

    it "removes an item from the basket" do
      basket_item
      expect {
        delete basket_item_path(basket_item)
      }.to change(BasketItem, :count).by(-1)
      expect(response).to redirect_to(basket_items_path)
    end
  end
end
