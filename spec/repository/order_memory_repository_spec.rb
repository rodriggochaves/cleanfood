require_relative "../../lib/repository/order_memory_repository"
require_relative "../../lib/entities/order"
require_relative "../factory_helper"

RSpec.describe OrderMemoryRepository do
  subject(:order_repository) { described_class.new }

  describe "the class interface" do
    it "responds to #save method" do
      expect(order_repository).to respond_to(:save)
    end

    it "responds to #all method" do
      expect(order_repository).to respond_to(:all)
    end

    it "responds to #destroy_all method" do
      expect(order_repository).to respond_to(:destroy_all)
    end
  end

  describe "the class implementation" do
    before do
      order_repository.destroy_all
    end

    it "#save pushes a new order to the list" do
      order = build(:order)
      expect { order_repository.save(order) }.to change { order_repository.all.count }.by(1)
    end

    it "returns #all orders in the list" do
      order_1 = build(:order)
      order_2 = build(:order)
      order_repository.save(order_1)
      order_repository.save(order_2)

      expect(order_repository.all).to match_array([order_1, order_2])
    end

    it '#destroy_all orders in the list' do
      order_1 = build(:order)
      order_2 = build(:order)
      order_repository.save(order_1)
      order_repository.save(order_2)

      expect { order_repository.destroy_all }.to change { order_repository.all.count }.from(2).to(0)
    end
  end
end
