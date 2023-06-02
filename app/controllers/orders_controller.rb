class OrdersController < ApplicationController
  before_action :set_order, only: %i[new update edit roy]

  def index
    @orders = current_user.orders
  end

  def show; end

  def new
    @order = Order.find(params[:id])
  end

  def create
    order = current_user.orders.in_cart.find_or_initialize_by(product_id: order_params[:product_id])
    order.quantity = order.quantity.to_i + 1

    if order.save
      redirect_to products_path, notice: 'Added to cart successfully.'
    else
      redirect_to products_path, alter: 'Something went wrong cannot be added to cart.'
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:user_id, :status, :product_id, :quantity)
  end
end
