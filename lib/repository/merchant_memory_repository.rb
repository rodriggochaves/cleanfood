

class MerchantMemoryRepository
  @@store = []

  def save(merchant)
    @@store << merchant
  end

  def all
    @@store
  end

  def find_by_name(name)
    @@store.find { |merchant| merchant.name == name }
  end

  def destroy_all
    @@store = []
  end
end
