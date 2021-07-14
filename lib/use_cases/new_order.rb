require_relative "../entities/order"

class NewOrder
  def initialize(customer:, merchant:, products:, repository:, notification:, payment:)
    @customer = customer
    @repository = repository
    @payment = payment
    @notification = notification
  end

  def execute
    Order.new.tap do |order|
      @repository.save(order)
      @payment.execute(@customer)
      @notification.execute(order)
    end
    # if valid_payment?
    #   # OrderRepository.save(order)
    #   # notify the store
    #   # charge the customer
    #   # return qualquer bosta with order status
    # else
    #   # return failure with invalid payment
    # end
  end
end
