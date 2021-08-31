require 'dry/monads'
require_relative "../entities/order"

class NewOrder
  include Dry::Monads[:result]

  def initialize(customer:, merchant:, products:, payment_info:, order_repository:, notification:, payment_service:)
    @customer = customer
    @merchant = merchant
    @products = products
    @order_repository = order_repository
    @payment_info = payment_info
    @payment_service = payment_service
    @notification = notification
  end

  def execute
    if @payment_info.valid?
      order = Order.new(merchant: @merchant, products: @products)
      @payment_service.execute(@customer)
        .then { @order_repository.save(order) }
        .then { @notification.execute(order) }

      Success(order)
    else
      Failure("Payment info is invalid.")
    end
  end
end
