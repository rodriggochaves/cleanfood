require_relative "../../factory_helper"
require_relative "../../../lib/entities/merchant"

FactoryBot.define do
  factory :merchant do
    name { "Ricco" }


    initialize_with do
      new(
        name: name
      )
    end
  end
end
