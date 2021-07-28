class Customer
  attr_reader :address, :name, :email, :cpf, :phone_number, :birthday

  def initialize(name:, email:, cpf:, phone_number:, birthday:, address:)
    @name = name
    @email = email
    @cpf = cpf
    @phone_number = phone_number
    @birthday = birthday
    @address = address
  end
end
