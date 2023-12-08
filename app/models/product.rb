class Product < ApplicationRecord
  has_many :basket_items, dependent: :destroy
  has_many :baskets, through: :basket_items
  has_many :promotions, dependent: :destroy

  validates :code, :name, :price, presence: true
  validates :code, uniqueness: true

  def price_value
    self.price / 100.0
  end

  def price_value=(amount)
    self.price = (amount.to_f * 100).round
  end
end
