class BasketItem < ApplicationRecord
  belongs_to :basket
  belongs_to :product

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def price_value
    (product.price / 100.0) * self.amount
  end
end
