require_relative "../../lib/entities/customer"
require_relative "../../lib/entities/address"

RSpec.describe Customer do
  let(:address) do
    Address.new(
      country: "br",
      state: "sp",
      city: "Cotia",
      neighborhood: "Rio Cotia",
      street: "Rua Matrix",
      street_number: "9999",
      zipcode: "06714360"
    )
  end

  let(:customer) do
    Customer.new(
      name: "Morpheus Fishburne",
      email: "mopheus@nabucodonozor.com",
      cpf: "30621143049",
      phone_number: "+5511999998888",
      birthday: "1965-01-01",
      address: address
    )
  end

  it "has an address" do
    expect(customer.address).to eq(address)
  end
end
