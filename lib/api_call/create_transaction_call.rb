class CreateTransactionCall
  URL = "https://api.pagar.me/1/transactions".freeze

  def initialize(http_client:, params:, headers:)
    @http_client = http_client
    @params = params
    @headers = headers
  end

  def execute
    @http_client.post(URL, params: @params, headers: @headers)
  end
end