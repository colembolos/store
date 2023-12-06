require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      product = Product.new(code: "001", name: "Test Product", price: 10.0)
      expect(product).to be_valid
    end
  
    it "is not valid without a name" do
      product = Product.new(code: "002", price: 20.0)
      expect(product).not_to be_valid
    end
  
    it "is not valid without a code" do
      product = Product.new(name: "Test Product", price: 30.0)
      expect(product).not_to be_valid
    end
  
    it "is not valid without a price" do
      product = Product.new(code: "003", name: "Test Product", price: nil)
      expect(product).not_to be_valid
    end
  
    it "is not valid with a duplicate code" do
      Product.create(code: "004", name: "Original Product", price: 40.0)
      duplicate_product = Product.new(code: "004", name: "Duplicate Product", price: 50.0)
      expect(duplicate_product).not_to be_valid
    end
  end
end
