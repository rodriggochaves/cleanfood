require "time"

class Merchant
  attr_reader :id, :name, :description, :average_ticket, :type, :open_time, :close_time, :address

  def initialize(id:, name:, description:, average_ticket:, type:, open_time:, close_time:, address:)
    @id = id
    @name = name
    @description = description
    @average_ticket =  average_ticket
    @type =  type
    @open_time =  open_time
    @close_time =  close_time
    @address =  address
  end

  def status(current_time: )
    if available?(current_time)
      "available"
    else
      "unavailable"
    end
  end

  private

  def available?(current_time)
    current_time > to_datetime(open_time) && current_time < to_datetime(close_time)
  end

  def to_datetime(time)
    Time.parse(time)
  end
end
