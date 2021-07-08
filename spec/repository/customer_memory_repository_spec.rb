require_relative "../../lib/repository/customer_memory_repository"
require_relative "../../lib/entities/customer"

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
    before do
      customer_repository.destroy_all
    end

    it "#all returns all customers stored" do
      customer_1 = Customer.new(address: "Seatle")
      customer_2 = Customer.new(address: "Chicago")

      customer_repository.save(customer_1)
      customer_repository.save(customer_2)

      expect(customer_repository.all).to match_array([customer_2, customer_1])
    end

    it "#save pushes a new customer to the list" do
      customer = Customer.new(address: "Seatle")
      expect { customer_repository.save(customer) }.to change { customer_repository.all.count }.by(1)
    end

    it "#destroy_all sets the store to be an empty array" do
      customer_repository.save(Customer.new(address: "Chicago"))
      customer_repository.destroy_all

      expect(customer_repository.all).to eq([])
    end
  end
end
