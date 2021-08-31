class Product
  attr_reader :name, :unit_price, :quantity

  def initialize(name: ,unit_price:)
    @name = name
    @unit_price = unit_price
  end
end
