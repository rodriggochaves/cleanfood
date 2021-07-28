require_relative "../../factory_helper"
require_relative "../../../lib/entities/product"

FactoryBot.define do
  factory :product do
    title { "Red pill" }
    unit_price { 1000 }
    quantity { 1 }

    initialize_with do
      new(
        title: title,
        unit_price: unit_price,
        quantity: quantity
      )
    end
  end
end
