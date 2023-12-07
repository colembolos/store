class BasketItemsController < ApplicationController
  def index
    @total_discount = basket.total_discount
  end

  def create
    basket_item = basket.basket_items.new(product: product)

    if basket_item.save
      redirect_to products_path, notice: 'Product added to basket successfully.'
    else
      redirect_to products_path, alert: 'Failed to add product to basket.'
    end
  end

  def destroy
    basket_item.destroy!

    redirect_to basket_items_path, notice: 'Product was successfully removed from the basket.'
  end

  private

  def create_params
    params.permit(:product_id)
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
