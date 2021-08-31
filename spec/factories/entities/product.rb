require_relative "../../factory_helper"
require_relative "../../../lib/entities/product"

FactoryBot.define do
  factory :product do
    name { "Red pill" }
    unit_price { 1000 }

    initialize_with do
      new(
        name: name,
        unit_price: unit_price,
      )
    end
  end
end
