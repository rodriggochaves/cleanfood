class Order
  attr_reader :merchant, :product_list

  def initialize(merchant:, product_list:)
    @merchant = merchant
    @product_list = product_list
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

  def status
    "placed"
  end

  def details
    {
      product: product_list_details,
      total: calculate_total
    }
  end

  private

  def product_list_details
    product_list.map do |product|
      {
        name: product.name,
        quantity: 1,
        unit_price: product.unit_price
      }
    end
  end

  def calculate_total
    product_list.sum(&:unit_price)
  end
end
