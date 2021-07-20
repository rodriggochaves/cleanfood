require_relative "../../lib/entities/payment_info"

RSpec.describe PaymentInfo do
  describe "#valid?" do

    context "when payment type is valid" do
      it "expects to return true" do
        payment_info = described_class.new(payment_type: :credit_card)

        expect(payment_info.valid?).to be true
      end
    end

    context "when payment type is invalid" do
      it "expects to return false" do
        payment_info = described_class.new(payment_type: :parapipa)

        expect(payment_info.valid?).to be false
      end
    end
  end
end
