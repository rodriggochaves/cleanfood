require_relative "../../lib/entities/customer"

require_relative "../factory_helper"

RSpec.describe Customer do
  let(:address) { build(:address) }
  let(:customer) { build(:customer, address: address) }

  it "has an address" do
    expect(customer.address).to eq(address)
  end
end
