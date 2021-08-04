class NotificationCallErrorMock
  @@message = nil

  def initialize(message:)
    @@message = message
  end

  def execute(order:, merchant:)
    raise StandardError
  end

  def message
    @@message
  end
end
