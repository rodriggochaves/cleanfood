require_relative "../../lib/services/charge_customer_service"
require_relative "../../lib/api_call/http_client_mock"
require_relative "../../lib/api_call/response_mock"
require_relative "../factory_helper"

RSpec.describe ChargeCustomerService do
  let(:customer) { build(:customer) }
  let(:shipping_address) { build(:address) }
  let(:products) { build_list(:product, 1) }
  let(:credit_card) { build(:credit_card) }
  let(:http_client) { HttpClientMock.new }


  describe "#execute" do
    context "when params are valid" do
      subject(:charge_customer) do
        described_class.new(
          customer: customer,
          shipping_address: shipping_address,
          products: products,
          credit_card: credit_card,
          http_client: http_client)
      end

      it "expects to return success" do
        response = Response.new(body: {status: "paid" })
        http_client.mock_responses(response: response)

        expect(charge_customer.execute).to be_success
      end
    end

    context "when params are invalid" do
      subject(:charge_customer) do
        described_class.new(
          customer: customer,
          shipping_address: shipping_address,
          products: products,
          credit_card: credit_card,
          http_client: http_client)
      end

      it "expects to return failure" do
        response = Response.new(body: { status: "not paid" })

        http_client.mock_responses(response: response)
        expect(charge_customer.execute).to be_failure
      end
    end
  end
end
