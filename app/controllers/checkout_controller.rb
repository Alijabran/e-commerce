class CheckoutController < ApplicationController
  def new; end

  def create_session
    stripe_service = StripeService.new(current_user, params[:order_id], success_checkout_index_url(order_id: params[:order_id])).create_session
    redirect_to stripe_service
  end

  def success
    order = Order.find(params[:order_id])
    return unless order.update(status: 'paid')

    redirect_to orders_path, alert: 'Order Placed'
  end

  def cancel; end

  def edit; end

  def update; end
end
