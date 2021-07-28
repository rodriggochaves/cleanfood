class ChargeCustomerService

  def initialize(customer:, shipping_address:, products:, card:, http_client:)
    @customer = customer
    @billing_address = customer.address
    @shipping_address = shipping_address
    @products = products
    @card = card
    @http_client = http_client
  end

  def execute
    CreateTransactionCall.new(
      params: params,
      http_client: @http_client
    ).execute
  end

  private

  def params
    {
      customer: @customer,
      billing_address: @customer.address,
      shipping_address: @shipping_address,
      products: @products,
      card: @card
    }
  end
end
