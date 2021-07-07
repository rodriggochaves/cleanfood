require_relative "../../lib/entities/customer"

RSpec.describe Customer do
  it "has an address" do
    customer = Customer.new(address: "Six's House, You went too far")
    expect(customer.address).to eq("Six's House, You went too far")
  end
end
