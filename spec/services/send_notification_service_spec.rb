require_relative "../factory_helper"
require_relative "../../lib/services/send_notification_service"
require_relative "../../lib/services/notification_call_mock"
require_relative "../../lib/services/notification_call_error_mock"

RSpec.describe SendNotificationService do
  subject(:send_notification) do
    described_class.new.execute(
      order: order,
      notification_call: notification_call_mock
    )
  end

  let(:order) { build(:order) }

  context "when params are correct" do
    let(:notification_call_mock) { NotificationCallMock.new(message: "Mensagem exemplo de Sucesso") }

    it 'executes with success' do
      expect(send_notification).to be_success
    end
  end

  context "when something unexpected happens" do
    let(:notification_call_mock) { NotificationCallErrorMock.new(message: "Mensagem exemplo de Sucesso") }

    it 'returns failure' do
      expect(send_notification).to be_failure
    end
  end
end
