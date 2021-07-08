require_relative "./lib/entities/customer"

require_relative "./lib/use_cases/new_order"

require_relative "./lib/repository/customer_memory_repository"

# Customer is asking a new order, by sending the address and the products


customer = Customer.new(address: "Seatle")
meatz = MerchantMemoryRepository.find(name: "Meatz")
burguer = meatz.products.find(name: "Bacon Burguer")

order = NewOrder.new(customer: customer, merchant: meatz, products: [burguer]).execute


# merchant = Struct.new(:name)
# product_1 = Struct.new(:name)

# order = NewOrder.new(customer: customer, merchant: merchant, products: [product_1]).execute
# puts order.driver_name

