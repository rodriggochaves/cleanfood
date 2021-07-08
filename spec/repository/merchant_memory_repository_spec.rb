require_relative "../../lib/repository/merchant_memory_repository"
require_relative "../../lib/entities/merchant"

RSpec.describe MerchantMemoryRepository do
  subject(:merchant_repository) { described_class.new }

  describe "the class interface" do
    it "responds to #all method" do
      expect(merchant_repository).to respond_to(:all)
    end

    it "responds to #save method" do
      expect(merchant_repository).to respond_to(:save)
    end

    it "responds to #find_by_name method" do
      expect(merchant_repository).to respond_to(:find_by_name)
    end

    it "responds to #destroy_all" do
      expect(merchant_repository).to respond_to(:destroy_all)
    end
  end

  describe "the class implementation" do
    before do
      merchant_repository.destroy_all
    end

    it "#all returns all merchant stored" do
      merchant_1 = Merchant.new(name: "Meatz")
      merchant_2 = Merchant.new(name: "Ricco")

      merchant_repository.save(merchant_1)
      merchant_repository.save(merchant_2)

      expect(merchant_repository.all).to match_array([merchant_2, merchant_1])
    end

    it "#save pushes a new merchant to the list" do
      merchant = Merchant.new(name: "Seatle")
      expect { merchant_repository.save(merchant) }.to change { merchant_repository.all.count }.by(1)
    end

    it "#destroy_all sets store as an empty array" do
      merchant_repository.save(Merchant.new(name: "Meatz"))
      merchant_repository.destroy_all
      expect(merchant_repository.all).to eq([])
    end

    it "#find_by_name returns the merchant with a specific name" do
      merchant = Merchant.new(name: "Meatz")
      merchant_repository.save(merchant)

      expect(merchant_repository.find_by_name("Meatz")).to eq(merchant)
    end
  end
end
