require_relative "../../factory_helper"
require_relative "../../../lib/entities/order"

FactoryBot.define do
  factory :order do
    merchant
    product_list { build_list(:product, 2) }

    initialize_with do
      new(
        merchant: merchant,
        product_list: product_list
      )
    end
  end
end
