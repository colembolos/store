require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /index" do
    let!(:product) { create(:product, name: "Test Product") }

    it "returns http success" do
      get products_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Test Product")
    end
  end
end
