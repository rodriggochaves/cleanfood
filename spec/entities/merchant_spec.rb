require_relative "../../lib/entities/merchant"
require_relative "../factory_helper"
require "time"
require "timecop"

RSpec.describe Merchant do
  describe "#status" do
    context "when time is between opened and closed hour" do
      it "expects to be available" do
        merchant = build(:merchant)
        available_time = Time.parse(merchant.open_time) + 1
        status = merchant.status(current_time: available_time)

        expect(status).to eq "available"
      end
    end

    context "when it is before opened and closed hour" do
      it "expects to be unavailable" do
        merchant = build(:merchant)
        unavailable_time = Time.parse(merchant.open_time) - 1
        status = merchant.status(current_time: unavailable_time)

        expect(status).to eq "unavailable"
      end
    end

    context "when it is after opened and closed hour" do
      it "expects to be unavailable" do
        merchant = build(:merchant)
        unavailable_time = Time.parse(merchant.close_time) + 1
        status = merchant.status(current_time: unavailable_time)

        expect(status).to eq "unavailable"
      end
    end
  end
end
