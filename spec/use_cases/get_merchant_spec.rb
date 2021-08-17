require_relative "../factory_helper"

require_relative "../../lib/use_cases/get_merchant"
require_relative "../../lib/repository/merchant_memory_repository"


RSpec.describe GetMerchant do
  let(:merchant) { build(:merchant) }
  let(:repository) { MerchantMemoryRepository.new }

  before do
    repository.save(merchant)
  end

  after do
    repository.destroy_all
  end

  context 'when ID exists' do
    subject(:get_merchant) { GetMerchant.new(id: merchant.id, repository: repository).execute }

    it 'expects to be success' do
      expect(get_merchant).to be_success
    end

    it 'expects to return a merchant' do
      expect(get_merchant.value!).to eql(merchant)
    end
  end

  context 'when ID does not exist' do
    subject(:get_merchant) { GetMerchant.new(id: merchant.id, repository: repository).execute }

    it 'expects to be a failure' do
      result = GetMerchant.new(id: "random ID", repository: repository).execute

      expect(result).to be_failure
    end

    it 'expects to return a :merchant_not_found' do
      result = GetMerchant.new(id: "random ID", repository: repository).execute

      expect(result.failure).to eq(:merchant_not_found)
    end
  end
end
