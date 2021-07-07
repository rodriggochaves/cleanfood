require_relative "./lib/entities/customer"

require_relative "./lib/use_cases/new_order"

require_relative "./repository/memory/customer_memory_repository"

customer_1 = Customer.new(address: "Washington")
customer_2 = Customer.new(address: "Seatle")
customer_3 = Customer.new(address: "Chicago")

repository = CustomerMemoryRepository.new
repository.save(customer_1)
repository.save(customer_2)
repository.save(customer_3)

pp repository.all




# merchant = Struct.new(:name)
# product_1 = Struct.new(:name)

# order = NewOrder.new(customer: customer, merchant: merchant, products: [product_1]).execute
# puts order.driver_name

