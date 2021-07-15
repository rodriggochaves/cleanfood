require_relative "./lib/entities/customer"
require_relative "./lib/entities/merchant"
require_relative "./lib/entities/payment_info"

require_relative "./lib/use_cases/new_order"

require_relative "./lib/services/notification_service"
require_relative "./lib/services/payment_service"

require_relative "./lib/repository/customer_memory_repository"
require_relative "./lib/repository/merchant_memory_repository"
require_relative "./lib/repository/payment_memory_repository"
require_relative "./lib/repository/order_memory_repository"

### Customer orders food from a store
customer = Customer.new(address: 'casa do rods')
customer_repository = CustomerMemoryRepository.new
customer_repository.save(customer)

merchant = Merchant.new(name: 'Ricco Burguer')
merchant_repository = MerchantMemoryRepository.new
merchant_repository.save(merchant)

payment_info = PaymentInfo.new
payment_repository = PaymentMemoryRepository.new
payment_repository.save(merchant)

order_repository = OrderMemoryRepository.new
notification_service = NotificationService.new
payment_service = PaymentService.new

new_order = NewOrder.new(
  customer: customer,
  merchant: merchant,
  products: [],
  payment_info: payment_info,
  repository: order_repository,
  notification: notification_service,
  payment: payment_service
).execute

puts "New order: #{new_order}"
