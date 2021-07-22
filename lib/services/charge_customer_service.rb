class ChargeCustomerService

  def initialize(customer:, shipping_address:, products:, card_hash:, http_client: )
    @customer = customer
    @billing_address = customer.address
    @shipping_address = shipping_address
    @products = products
    @card_hash = card_hash
    @http_client = http_client
  end

  def execute
    CreateTransactionCall.new()
  end

  private

  def params
    {

    }
  end
end
