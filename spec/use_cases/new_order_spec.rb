require_relative "../../lib/use_cases/new_order"

require_relative "../../lib/entities/customer"

RSpec.describe NewOrder do
  it "expects to return an Order confirmed" do
    customer = Customer.new(address: "Passagem Santo Antonio, Terra Firme")
    merchant = Struct.new(:name)
    product_1 = Struct.new(:name)

    new_order_use_case = NewOrder.new(customer: customer, merchant: merchant, products: [product_1])
    order = new_order_use_case.execute
    expect(order.confirmed?).to be_truthy
  end
end
