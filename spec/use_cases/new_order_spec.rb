require_relative "../../lib/use_cases/new_order"

require_relative "../factory_helper"

RSpec.describe NewOrder do
  let(:address) { build(:address) }
  let(:customer) { build(:customer) }


  let(:payment_info) { double('PaymentInfoMock', valid?: true) }
  let(:repository_mock) { double('OrderRepositoryMock', save: nil) }
  let(:notification_service_mock) { double('NotifyServiceMock', execute: nil) }
  let(:payment_service_mock) { double('PaymentServiceMock', execute: nil) }

  subject(:new_order) do
    described_class.new(
      customer: customer,
      merchant: nil,
      products: nil,
      payment_info: payment_info,
      order_repository: repository_mock,
      notification: notification_service_mock,
      payment_service: payment_service_mock
    ).execute
  end

  context 'when payment information is valid' do
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

    it 'returns success with an order as result' do
      expect(new_order).to be_success
    end

    it 'returns success with an order as result' do
      expect(new_order.value!).to be_an_instance_of Order
    end
  end

  context 'when payment information is not valid' do
    let(:payment_info) do
      double('PaymentInfoMock', valid?: false, errors: ['credit card number is not valid'])
    end

    it 'returns an error with a message explaining it' do
      expect(new_order).to be_failure
    end

    it 'returns an error with a message explaining it' do
      expect(new_order.failure).to eq "Payment info is invalid."
    end
  end
end
