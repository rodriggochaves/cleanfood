require_relative "../../lib/repository/customer_memory_repository"

require_relative "../factory_helper"

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
    let(:address) { build(:address) }
    let(:customer) { build(:customer) }

    before do
      customer_repository.destroy_all
    end

    it "#all returns all customers stored" do
      customers = build_list(:customer, 2)
      customers.map { |customer| customer_repository.save(customer) }

      expect(customer_repository.all).to match_array(customers)
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
