class NotificationCallMock
  @@message = nil

  def initialize(message:)
    @@message = message
  end

  def execute(order:, merchant:)
  end

  def message
    @@message
  end
end
