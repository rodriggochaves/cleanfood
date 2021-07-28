require_relative "../../lib/api_call/create_transaction_call"
require_relative "../../lib/entities/credit_card"
require_relative "../../lib/entities/customer"
require_relative "../../lib/entities/address"
require_relative "../../lib/entities/product"

RSpec.describe CreateTransactionCall do
  let(:customer) do
    Customer.new(
      name: "Morpheus Fishburne",
      email: "mopheus@nabucodonozor.com",
      cpf: "30621143049",
      phone_number: "+5511999998888",
      birthday: "1965-01-01",
      address: address
    )
  end

  let(:address) do
    Address.new(
      country: "br",
      state: "sp",
      city: "Cotia",
      neighborhood: "Rio Cotia",
      street: "Rua Matrix",
      street_number: "9999",
      zipcode: "06714360"
    )
  end

  let(:products) do
    [
      Product.new(
        title: "Red pill",
        unit_price: 1000,
        quantity: 1
      )
    ]
  end

  let(:params) do
    {
      customer: customer,
      billing_address: "",
      shipping_address: "",
      products: products,
      credit_card: CreditCard.new(
        number: "4111111111111111",
        cvv: "123",
        expiration_date: "0922",
        holder_name: "Morpheus Fishburne",
      )
    }
  end

  let(:http_client) do
    double("HTTP Client", post: { status: 200 })
  end

  subject(:create_transaction_call) do
    described_class.new(params: params, http_client: http_client).execute
  end

  describe "#execute" do
    describe "the request payload sent" do
      it "expects to send the credit card params" do
        expect(http_client).to receive(:post).with(hash_including({
          params: hash_including({
            card_number: "4111111111111111",
            card_cvv: "123",
            card_expiration_date: "0922",
            card_holder_name: "Morpheus Fishburne",
          })
        }))
        create_transaction_call
      end

      it "expects to send the customer params" do
        expect(http_client).to receive(:post).with(hash_including({
          params: hash_including({
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
          })
        }))
        create_transaction_call
      end

      it "expects to send the address params" do
        expect(http_client).to receive(:post).with(hash_including({
          params: hash_including({
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
          })
        }))
        create_transaction_call
      end

      it "expects to send the address params" do
        expect(http_client).to receive(:post).with(hash_including({
          params: hash_including({
            shipping: {
              address: {
                country: "br",
                state: "sp",
                city: "Cotia",
                street: "Rua Matrix",
                neighborhood: "Rio Cotia",
                street_number: "9999",
                zipcode: "06714360"
              }
            }
          })
        }))
        create_transaction_call
      end

      it "expects to send the items params" do
        expect(http_client).to receive(:post).with(hash_including({
          params: hash_including({
            items: [
              {
                title: "Red pill",
                unit_price: 1000,
                quantity: 1
              }
            ]
          })
        }))
        create_transaction_call
      end
    end
  end
end
