class CustomerMemoryRepository
  def initialize
    @store = []
  end

  def save(customer)
    @store << customer
  end

  def all
    @store
  end
end
