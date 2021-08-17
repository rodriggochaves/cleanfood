require_relative "../../factory_helper"
require_relative "../../../lib/entities/merchant"

FactoryBot.define do
  factory :merchant do
    id { "unique merchant id" }
    name { "Ricco" }
    description { "Very expensive hamburguer" }
    average_ticket { 50.0 }
    type { 'restaurant' }
    open_time { '17:00' }
    close_time { '23:00' }
    address { "some complex address in the future" }

    initialize_with do
      new(
        id: id,
        name: name,
        description: description,
        average_ticket: average_ticket,
        type: type,
        open_time: open_time,
        close_time: close_time,
        address: address
      )
    end
  end
end
