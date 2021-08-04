require_relative "../../factory_helper"
require_relative "../../../lib/entities/order"

FactoryBot.define do
  factory :order do
    merchant
    products { build_list(:product, 2) }

    initialize_with do
      new(
        merchant: merchant,
        products: products
      )
    end
  end
end
