class CreateTransactionCall
  URL = "https://api.pagar.me/1/transactions".freeze

  attr_reader :params

  def initialize(http_client:, params:, headers: {})
    @http_client = http_client
    @params = params
    @headers = headers
  end

  def execute
    @http_client.post(url: URL, params: payload, headers: @headers)
  end

  private def payload
    {
      card_number: params[:credit_card].number,
      card_cvv: params[:credit_card].cvv,
      card_expiration_date: params[:credit_card].expiration_date,
      card_holder_name: params[:credit_card].holder_name,
      customer: {
        name: params[:customer].name,
        email: params[:customer].email,
        documents: [
          {
            type: "cpf",
            number: params[:customer].cpf
          }
        ],
        phone_numbers: [params[:customer].phone_number],
        birthday: params[:customer].birthday
      },
      billing: {
        address: {
          country: params[:customer].address.country,
          state: params[:customer].address.state,
          city: params[:customer].address.city,
          neighborhood: params[:customer].address.neighborhood,
          street: params[:customer].address.street,
          street_number: params[:customer].address.street_number,
          zipcode: params[:customer].address.zipcode
        }
      },
      shipping: {
        address: {
          country: params[:customer].address.country,
          state: params[:customer].address.state,
          city: params[:customer].address.city,
          neighborhood: params[:customer].address.neighborhood,
          street: params[:customer].address.street,
          street_number: params[:customer].address.street_number,
          zipcode: params[:customer].address.zipcode
        }
      },
      items: items
    }
  end

  private def items
    params[:products].map do |product|
      {
        title: product.title,
        unit_price: product.unit_price,
        quantity: product.quantity
      }
    end
  end
end
