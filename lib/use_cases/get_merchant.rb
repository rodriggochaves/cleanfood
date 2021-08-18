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
      Success(to_hash(merchant))
    else
      Failure(:merchant_not_found)
    end
  end

  private

  attr_reader :id, :repository

  def to_hash(merchant)
    {
      id: merchant.id,
      name: merchant.name,
      description: merchant.description,
      average_ticket: merchant.average_ticket,
      type: merchant.type,
      open_time: merchant.open_time,
      close_time: merchant.close_time,
      address: merchant.address,
      status: 'available'
    }
  end
end
