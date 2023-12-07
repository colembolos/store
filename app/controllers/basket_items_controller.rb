class BasketItemsController < ApplicationController
  def index
    @total = basket.total
  end

  def create
    basket_item = basket.basket_items.find_or_initialize_by(product: product)
    basket_item.amount += amount_param.to_i

    if basket_item.save
      redirect_to products_path, notice: 'Product added to basket successfully.'
    else
      redirect_to products_path, alert: 'Failed to add product to basket.'
    end
  end

  def destroy
    if amount_param.to_i >= basket_item.amount
      basket_item.destroy!
    else
      basket_item.amount -= amount_param.to_i
      basket_item.save!
    end

    redirect_to basket_items_path, notice: 'Product was successfully removed from the basket.'
  end

  private

  def create_params
    params.permit(:product_id, :amount)
  end

  def amount_param
    params.require(:amount)
  end

  def basket
    @basket ||= current_user.basket || current_user.create_basket
  end

  def product
    @product ||= Product.find(create_params[:product_id])
  end

  def basket_item
    @basket_item ||= BasketItem.find(params[:id])
  end
end
