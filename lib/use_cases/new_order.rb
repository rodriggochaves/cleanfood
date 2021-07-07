require_relative "../entities/order"

class NewOrder
  def initialize(customer:, merchant:, products:)
  end

  def execute
    Order.new
  end
end
