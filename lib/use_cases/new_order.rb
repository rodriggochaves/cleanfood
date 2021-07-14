require_relative "../entities/order"

class NewOrder
  def initialize(customer:, merchant:, products:, repository:)
    @repository = repository
  end

  def execute
    @repository.save(Order.new)
    Order.new
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
