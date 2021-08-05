require_relative "./lib/entities/address"
require_relative "./lib/entities/customer"
require_relative "./lib/entities/merchant"
require_relative "./lib/entities/product"
require_relative "./lib/entities/credit_card"
require_relative "./lib/entities/payment_info"

require_relative "./lib/use_cases/new_order"

require_relative "./lib/api_call/http_client_mock"
require_relative "./lib/api_call/response_mock"

require_relative "./lib/services/send_notification_service"
require_relative "./lib/services/charge_customer_service"

require_relative "./lib/repository/customer_memory_repository"
require_relative "./lib/repository/merchant_memory_repository"
require_relative "./lib/repository/payment_memory_repository"
require_relative "./lib/repository/order_memory_repository"

### Customer orders food from a store
address = Address.new(
  country: "BR",
  state: "Paraná",
  city: "Curitiba",
  neighborhood: "Parapipa",
  street: "Parapupa",
  street_number: "12",
  zipcode: "88721312"
)

customer = Customer.new(
  name: "David",
  email: "david@inc.com",
  cpf: "001.001.001-01",
  phone_number: "61999999999",
  birthday: "12-04-1996",
  address: address
)
customer_repository = CustomerMemoryRepository.new
customer_repository.save(customer)

merchant = Merchant.new(name: 'Ricco Burguer')
merchant_repository = MerchantMemoryRepository.new
merchant_repository.save(merchant)

product = Product.new(title: 'Cheddar da Casa', unit_price: '39.9')

payment_info = PaymentInfo.new(payment_type: :credit_card)
payment_repository = PaymentMemoryRepository.new
payment_repository.save(payment_info)

order_repository = OrderMemoryRepository.new
notification_service = SendNotificationService.new(notification_call: @notification_call)

credit_card = CreditCard.new(
  number: '4111-111-1111-111',
  cvv: '123',
  expiration_date: '01/2030',
  holder_name: 'David'
)

http_client = HttpClientMock.new
http_client.mock_responses(response: Response.new(body: { status: "paid" }))

charge_customer_service = ChargeCustomerService.new(
  customer: customer,
  shipping_address: address,
  products: [product],
  credit_card: credit_card,
  http_client: http_client
)

new_order = NewOrder.new(
  customer: customer,
  merchant: merchant,
  products: [product],
  payment_info: payment_info,
  order_repository: order_repository,
  notification: notification_service,
  payment_service: charge_customer_service
).execute

puts "New order: #{new_order}"


Listenner.sub("ordem criada") do |id|
  notification_service = SendNotificationService.new(notification_call: @notification_call)
  order = OrderRepository.find(id)
  send_notification_service.execute(order)
end
