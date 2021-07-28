require_relative "../../lib/repository/customer_memory_repository"
require_relative "../../lib/entities/customer"
require_relative "../../lib/entities/address"

RSpec.describe CustomerMemoryRepository do
  subject(:customer_repository) { described_class.new }

  describe "the class interface" do
    it "responds to #all method" do
      expect(customer_repository).to respond_to(:all)
    end

    it "responds to #save method" do
      expect(customer_repository).to respond_to(:save)
    end

    it "responds to #destroy_all method" do
      expect(customer_repository).to respond_to(:destroy_all)
    end
  end

  describe "the class implementation" do
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

    before do
      customer_repository.destroy_all
    end

    it "#all returns all customers stored" do
      customer_1 = Customer.new(
        name: "Morpheus Fishburne",
        email: "mopheus@nabucodonozor.com",
        cpf: "30621143049",
        phone_number: "+5511999998888",
        birthday: "1965-01-01",
        address: address
      )
      customer_2 = Customer.new(
        name: "Fishburne Morpheus",
        email: "mopheus@nabucodonozor.com",
        cpf: "30621143049",
        phone_number: "+5511999998888",
        birthday: "1965-01-01",
        address: address
      )

      customer_repository.save(customer_1)
      customer_repository.save(customer_2)

      expect(customer_repository.all).to match_array([customer_2, customer_1])
    end

    it "#save pushes a new customer to the list" do
      expect { customer_repository.save(customer) }.to change { customer_repository.all.count }.by(1)
    end

    it "#destroy_all sets the store to be an empty array" do
      customer_repository.save(customer)
      customer_repository.destroy_all

      expect(customer_repository.all).to eq([])
    end
  end
end
