class Product < ApplicationRecord
  validates :code, :name, :price, presence: true
  validates :code, uniqueness: true

  def price_value
    self.price / 100.0
  end

  def price_value=(amount)
    self.price = (amount.to_f * 100).round
  end
end
