class Basket < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :basket_items, dependent: :destroy
  has_many :products, through: :basket_items

  def total
    basket_items.inject(0) do |sum, item|
      sum + (item.product.price * item.amount)
    end
  end
end
