require_relative "../../lib/use_cases/new_order"
require_relative "../../lib/entities/customer"

require "timecop"

RSpec.describe NewOrder do
  it 'saves an Order' do
    repository = double('OrderRepositoryMock', save: nil)
    new_order = NewOrder.new(customer: nil, merchant: nil, products: nil, repository: repository)

    expect(repository).to receive(:save).with(an_instance_of(Order))
    new_order.execute
  end

  xit "expects to return an Order confirmed" do
    customer = Customer.new(address: "Passagem Santo Antonio, Terra Firme")
    merchant = Struct.new(:name)
    product_1 = Struct.new(:name)

    new_order_use_case = NewOrder.new(customer: customer, merchant: merchant, products: [product_1])
    order = new_order_use_case.execute
    expect(order.confirmed?).to be_truthy
  end

  xit "expects to return an estimated time" do
    Timecop.freeze
    customer = Customer.new(address: "Passagem Santo Antonio, Terra Firme")
    merchant = Struct.new(:name)
    product_1 = Struct.new(:name)

    new_order_use_case = NewOrder.new(customer: customer, merchant: merchant, products: [product_1])
    order = new_order_use_case.execute
    expect(order.estimated_time).to eq(Time.now + 20 * 60)
  end

  xit "expects to return the driver's name" do
    customer = Customer.new(address: "Passagem Santo Antonio, Terra Firme")
    merchant = Struct.new(:name)
    product_1 = Struct.new(:name)

    new_order_use_case = NewOrder.new(customer: customer, merchant: merchant, products: [product_1])
    order = new_order_use_case.execute
    expect(order.driver_name).to eq("David")
  end

  after do
    Timecop.return
  end
end
