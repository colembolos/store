class Basket < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :basket_items, dependent: :destroy
  has_many :products, through: :basket_items

  def total
    basket_items.inject(0) do |sum, item|
      sum + item.product.price
    end
  end

  def total_discount
    grouped_items.reduce(0) do |total, item|
      total + apply_promotions(item)
    end
  end

  def grouped_items
    basket_items.select('product_id, count(*) as amount').group(:product_id)
  end

  private

  def apply_promotions(basket_item)
    applicable_promotions = basket_item.product.promotions

    if applicable_promotions.any?
      applicable_promotions.map { |promotion| promotion.apply(basket_item) }.min
    else
      basket_item.amount * basket_item.product.price
    end
  end
end
