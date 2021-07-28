class Address
  attr_reader :country, :state, :city, :neighborhood, :street, :street_number, :zipcode

  def initialize(country:, state:, city:, neighborhood:, street:, street_number:, zipcode:)
    @country = country
    @state = state
    @city = city
    @neighborhood = neighborhood
    @street = street
    @street_number = street_number
    @zipcode = zipcode
  end
end
