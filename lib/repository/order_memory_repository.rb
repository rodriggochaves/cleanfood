class OrderMemoryRepository
  @@store = []

  def save(order)
    @@store << order
  end

  def all
    @@store
  end

  def destroy_all
    @@store = []
  end
end
