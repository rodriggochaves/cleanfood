require_relative "../../lib/use_cases/new_order"
require_relative "../../lib/entities/customer"

require "timecop"

RSpec.describe NewOrder do
  let(:customer) { Customer.new(address: 'address') }
  let(:repository_mock) { double('OrderRepositoryMock', save: nil) }
  let(:notification_service_mock) { double('NotifyServiceMock', execute: nil) }
  let(:payment_service_mock) { double('PaymentServiceMock', execute: nil) }

  subject(:new_order) do
    described_class.new(
      customer: customer,
      merchant: nil,
      products: nil,
      repository: repository_mock,
      notification: notification_service_mock,
      payment: payment_service_mock
    ).execute
  end

  it 'saves an Order' do
    expect(repository_mock).to receive(:save).with(an_instance_of(Order))
    new_order
  end

  it 'notify the Merchant about the created order' do
    expect(notification_service_mock).to receive(:execute).with(an_instance_of(Order))
    new_order
  end

  it 'charges the customer' do
    expect(payment_service_mock).to receive(:execute).with(an_instance_of(Customer))
    new_order
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
