require_relative "../../factory_helper"
require_relative "../../../lib/entities/order"

FactoryBot.define do
  factory :order do
    merchant

    initialize_with do
      new(
        merchant: merchant
      )
    end
  end
end
