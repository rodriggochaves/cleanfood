require 'dry/monads'

class GetMerchant
  include Dry::Monads[:result]

  def initialize(id:, repository:)
    @id = id
    @repository = repository
  end

  def execute
    merchant = repository.find(id: id)
    if merchant
      Success(merchant)
    else
      Failure(:merchant_not_found)
    end
  end

  private

  attr_reader :id, :repository
end
