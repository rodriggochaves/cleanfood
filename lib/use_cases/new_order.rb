require 'dry/monads'
require_relative "../entities/order"

class NewOrder
  include Dry::Monads[:result]

  def initialize(customer:, merchant:, products:, payment_info:, repository:, notification:, payment_service:)
    @customer = customer
    @merchant = merchant
    @repository = repository
    @payment_info = payment_info
    @payment_service = payment_service
    @notification = notification
  end

  def execute
    if @payment_info.valid?
      order = Order.new(merchant: @merchant)
      @repository.save(order)
        .then { @payment_service.execute(@customer) }
        .then { @notification.execute(order) }

      Success(order)
      # { success: true, result: order, errors: [] }
    else
      Failure("Payment info is invalid.")
      # { success: false, result: nil, errors: @payment_info.errors }
    end
  end
end
