require_relative "../../factory_helper"
require_relative "../../../lib/entities/address"

FactoryBot.define do
  factory :address do
    country { "br" }
    state { "sp" }
    city { "Cotia" }
    neighborhood { "Rio Cotia" }
    street { "Rua Matrix" }
    street_number { "9999" }
    zipcode { "06714360" }

    initialize_with do
      new(
        country: country,
        state: state,
        city: city,
        neighborhood: neighborhood,
        street: street,
        street_number: street_number,
        zipcode: zipcode
      )
    end
  end
end
