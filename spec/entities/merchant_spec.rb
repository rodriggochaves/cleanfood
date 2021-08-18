require_relative "../../lib/entities/merchant"
require_relative "../factory_helper"
require "time"
require "timecop"

RSpec.describe Merchant do
  describe "#status" do
    context "when time is between opened and closed hour" do
      it "expects to be available" do
        merchant = build(:merchant)
        Timecop.freeze(Time.parse(merchant.open_time) + 1)

        expect(merchant.status).to eq "available"
      end
    end

    context "when it is before opened and closed hour" do
      it "expects to be unavailable" do
        merchant = build(:merchant)
        Timecop.freeze(Time.parse(merchant.open_time) - 1)

        expect(merchant.status).to eq "unavailable"
      end
    end

    context "when it is after opened and closed hour" do
      it "expects to be unavailable" do
        merchant = build(:merchant)
        Timecop.freeze(Time.parse(merchant.close_time) + 1)

        expect(merchant.status).to eq "unavailable"
      end
    end
  end
end
