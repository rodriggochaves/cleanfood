require 'dry/monads'
require_relative "../entities/order"

class NewOrder
  attr_reader :merchant, :product_list

  include Dry::Monads[:result]

  def initialize(customer:, merchant:, product_list:)
    @customer = customer
    @merchant = merchant
    @product_list = product_list
  end

  def execute
    Success(new_order)
  end

  private

  def new_order
    Order.new(
      product_list: product_list,
      merchant: merchant
    )
  end
end
