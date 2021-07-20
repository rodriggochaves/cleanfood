require_relative "../entities/order"

class NewOrder
  def initialize(customer:, merchant:, products:, payment_info:, repository:, notification:, payment_service:)
    @customer = customer
    @repository = repository
    @payment_info = payment_info
    @payment_service = payment_service
    @notification = notification
  end

  def execute
    if @payment_info.valid?
      order = Order.new
      @repository.save(order)
      @payment_service.execute(@customer)
      @notification.execute(order)
      { success: true, result: order, errors: [] }
    else
      { success: false, result: nil, errors: @payment_info.errors }
    end
  end
end
