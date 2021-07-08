class CustomerMemoryRepository
  @@store = []

  def save(customer)
    @@store << customer
  end

  def all
    @@store
  end

  def destroy_all
    @@store = []
  end
end
