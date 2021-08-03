require 'dry/monads'
require_relative "../api_call/create_transaction_call"

class ChargeCustomerService
  include Dry::Monads[:result]

  def initialize(customer:, shipping_address:, products:, credit_card:, http_client:)
    @customer = customer
    @billing_address = customer.address
    @shipping_address = shipping_address
    @products = products
    @credit_card = credit_card
    @http_client = http_client
  end

  def execute
    response = CreateTransactionCall.new(
      params: params,
      http_client: @http_client
    ).execute

    if response[:status] === "paid"
      Success(response)
    else
      Failure(response)
    end
  end

  private

  def params
    {
      customer: @customer,
      billing_address: @customer.address,
      shipping_address: @shipping_address,
      products: @products,
      credit_card: @credit_card
    }
  end
end
