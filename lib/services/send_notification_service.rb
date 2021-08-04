require 'dry/monads'

class SendNotificationService
  include Dry::Monads[:result]

  def execute(order:, notification_call:)
    merchant = order.merchant
    notification_call.execute(order: order, merchant: merchant)

    Success(true)
  rescue StandardError => error
    Failure(error)
  end
end
