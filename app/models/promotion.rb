class Promotion < ApplicationRecord
  belongs_to :product

  enum promotion_type: %i[get_one_free bulk_discount bulk_percentage]

  validates :promotion_type, :threshold, presence: true

  def apply(basket_item)
    if get_one_free?
      apply_get_one_free(basket_item)
    elsif bulk_discount?
      apply_bulk_discount(basket_item)
    elsif bulk_percentage?
      apply_bulk_percentage(basket_item)
    else
      basket_item.amount * product.price
    end
  end

  private

  def apply_get_one_free(basket_item)
    quantity = basket_item.amount

    (quantity / threshold) * product.price + (quantity % threshold) * product.price
  end

  def apply_bulk_discount(basket_item)
    quantity = basket_item.amount

    if quantity >= threshold
      quantity * rules.fetch('discounted_price', product.price)
    else
      quantity * product.price
    end
  end

  def apply_bulk_percentage(basket_item)
    quantity = basket_item.amount

    if quantity >= threshold
      discount = (product.price * rules.fetch('discount_percentage', 10000)) / 10000
      quantity * (product.price - discount)
    else
      quantity * product.price
    end
  end
end
