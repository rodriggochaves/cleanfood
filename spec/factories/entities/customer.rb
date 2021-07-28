require_relative "../../factory_helper"
require_relative "../../../lib/entities/customer"

FactoryBot.define do
  factory :customer do
    name { "Morpheus Fishburne" }
    email { "mopheus@nabucodonozor.com" }
    cpf { "30621143049" }
    phone_number { "+5511999998888" }
    birthday { "1965-01-01" }
    address

    initialize_with do
      new(
        name: name,
        email: email,
        cpf: cpf,
        phone_number: phone_number,
        birthday: birthday,
        address: address
      )
    end
  end
end
