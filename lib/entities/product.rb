class Product
  attr_reader :title,:unit_price,:quantity

  def initialize(title: ,unit_price: ,quantity:)
    @title = title
    @unit_price = unit_price
    @quantity = quantity
  end
end
