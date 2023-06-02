class StripeService
  attr_accessor :order_id, :product, :current_user, :success_url

  def initialize(current_user, order_id, success_url)
    Stripe.api_key = ENV.fetch('STRIPE_SECRET_KEY', nil)
    @current_user = current_user
    @order_id = order_id
    @success_url = success_url
  end

  def create_session
    order = Order.find(order_id)
    product = order.product
    price = Stripe::Price.create({
                                   unit_amount: product.price.to_i,
                                   currency: 'usd',
                                   product_data: {
                                     name: product.title
                                   }
                                 })
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price: price,
          quantity: order.quantity
        }
      ],

      metadata: {
        address: current_user.address
      },
      mode: 'payment',
      success_url: success_url,
      cancel_url: 'http://localhost:3000/checkout/cancel'
    )
    session.url
  end
end
