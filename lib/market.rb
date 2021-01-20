class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item_name)
    @vendors.select do |vendor|
      vendor.sells?(item_name)
    end
  end

  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.item_names
    end.uniq.sort
  end
end
