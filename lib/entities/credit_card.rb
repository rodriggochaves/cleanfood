class CreditCard
  attr_reader :number, :cvv, :expiration_date, :holder_name

  def initialize(number:, cvv:, expiration_date:, holder_name:)
    @number = number
    @cvv = cvv
    @expiration_date = expiration_date
    @holder_name = holder_name
  end
end
