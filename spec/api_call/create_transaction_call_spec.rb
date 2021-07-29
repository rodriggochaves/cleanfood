require_relative "../../lib/api_call/create_transaction_call"
require_relative "../../lib/api_call/http_client_mock"
require_relative "../../lib/entities/credit_card"
require_relative "../factory_helper"

RSpec.describe CreateTransactionCall do
  let(:customer) { build(:customer) }
  let(:address) { build(:address) }
  let(:products) { build_list(:product, 1) }
  let(:credit_card) { build(:credit_card) }
  let(:http_client) { HttpClientMock.new }

  let(:params) do
    {
      customer: customer,
      billing_address: "",
      shipping_address: "",
      products: products,
      credit_card: credit_card
    }
  end


  subject(:create_transaction_call) do
    described_class.new(params: params, http_client: http_client).execute
  end

  describe "#execute" do
    describe "sends a payload request" do
      let(:last_request_params) do
        last_request = http_client.last_request
        last_request[:params]
      end

      it "expects to send the credit card params" do
        create_transaction_call
        expect(last_request_params).to match(hash_including({
          card_number: "4111111111111111",
          card_cvv: "123",
          card_expiration_date: "0922",
          card_holder_name: "Morpheus Fishburne"
        }))
      end

      it "expects to send the customer params" do
        create_transaction_call
        expect(last_request_params).to match(hash_including({
          customer: {
            name: "Morpheus Fishburne",
            email: "mopheus@nabucodonozor.com",
            documents: [
              {
                type: "cpf",
                number: "30621143049"
              }
            ],
            phone_numbers: ["+5511999998888"],
            birthday: "1965-01-01"
          }
        }))
      end

      it "expects to send the billing address params" do
        create_transaction_call
        expect(last_request_params).to match(hash_including({
          billing: {
            address: {
              country: "br",
              state: "sp",
              city: "Cotia",
              neighborhood: "Rio Cotia",
              street: "Rua Matrix",
              street_number: "9999",
              zipcode: "06714360"
            }
          }
        }))
      end

      it "expects to send the shipping address params" do
        create_transaction_call
        expect(last_request_params).to match(hash_including({
          shipping: {
            address: {
              country: "br",
              state: "sp",
              city: "Cotia",
              neighborhood: "Rio Cotia",
              street: "Rua Matrix",
              street_number: "9999",
              zipcode: "06714360"
            }
          }
        }))
      end

      it "expects to send the items params" do
        create_transaction_call
        expect(last_request_params).to match(hash_including({
          items: [
            {
              title: "Red pill",
              unit_price: 1000,
              quantity: 1
            }
          ]
        }))
      end
    end

    context "when the request is success" do
      it "returns the body of the request" do
        expect(create_transaction_call).to eq({
          status: "paid"
        })
      end
    end
  end
end
