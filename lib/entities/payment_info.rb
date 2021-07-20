class PaymentInfo
  PAYMENT_TYPES = [:credit_card, :debit_card, :food_allowance_card, :pix, :wallet]
  # card_number, expiration_date, cvc

  def initialize(payment_type:)
    @payment_type = payment_type
  end

  def valid?
    PAYMENT_TYPES.include?(@payment_type)
  end
end
