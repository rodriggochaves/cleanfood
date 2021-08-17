require_relative "../../factory_helper"
require_relative "../../../lib/entities/merchant"

FactoryBot.define do
  factory :merchant do
    id { "unique merchant id" }
    name { "Ricco" }


    initialize_with do
      new(
        id: id,
        name: name
      )
    end
  end
end
