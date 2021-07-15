require_relative "../entities/order"

class NewOrder
  def initialize(customer:, merchant:, products:, payment_info:, repository:, notification:, payment:)
    @customer = customer
    @repository = repository
    @payment_info = payment_info
    @payment = payment
    @notification = notification
  end

  def execute
    if @payment_info.valid?
      order = Order.new
      @repository.save(order)
      @payment.execute(@customer)
      @notification.execute(order)
    else
      { success: false, result: nil, errors: @payment_info.errors }
    end
  end
end
