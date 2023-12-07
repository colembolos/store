class BasketItem < ApplicationRecord
  belongs_to :basket
  belongs_to :product

  def price_value
    product.price / 100.0
  end
end
