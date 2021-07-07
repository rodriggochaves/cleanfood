class Order
  def initialize
  end

  def confirmed?
    true
  end

  def estimated_time
    Time.now + (20 * 60)
  end

  def driver_name
    "David"
  end
end
