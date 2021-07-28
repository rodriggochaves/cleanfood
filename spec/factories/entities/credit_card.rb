require_relative "../../factory_helper"
require_relative "../../../lib/entities/credit_card"

FactoryBot.define do
  factory :credit_card do
    number { "4111111111111111" }
    cvv { "123" }
    expiration_date { "0922" }
    holder_name { "Morpheus Fishburne" }

    initialize_with do
      new(
        number: number,
        cvv: cvv,
        expiration_date: expiration_date,
        holder_name: holder_name
      )
    end
  end
end
