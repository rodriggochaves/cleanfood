require_relative "./lib/entities/customer"

require_relative "./lib/use_cases/new_order"

customer = Customer.new(address: "Washtigon brigde")
merchant = Struct.new(:name)
product_1 = Struct.new(:name)

order = NewOrder.new(customer: customer, merchant: merchant, products: [product_1]).execute
puts order.driver_name


