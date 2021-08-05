class Product
  attr_reader :title, :unit_price, :quantity

  def initialize(title: ,unit_price:)
    @title = title
    @unit_price = unit_price
  end
end
