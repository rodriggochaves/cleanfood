require_relative "../../lib/use_cases/new_order"
require_relative "../../lib/entities/order"

require_relative "../factory_helper"

RSpec.describe NewOrder do
  subject(:new_order) { NewOrder.new(customer: customer, merchant: merchant, product_list: product_list).execute }

  let(:customer) { build(:customer) }
  let(:merchant) { build(:merchant) }
  let(:product_list) { [build(:product, name: "Cheddar da Casa"), build(:product, name: "Trufado")] }

  it 'expects to be successful' do
    expect(new_order).to be_success
  end

  it 'expects to return a new order' do
    expect(new_order.value!).to be_instance_of(Order)
  end

  it 'expects to order to be placed' do
    expect(new_order.value!.status).to eq("placed")
  end

  it 'expects to be able to access the order details' do
    expect(new_order.value!.details).to eq({
      product: [
        { name: "Cheddar da Casa", quantity: 1, unit_price: 1000 },
        { name: "Trufado", quantity: 1, unit_price: 1000 },
      ],
      total: 2000
    })
  end
end
