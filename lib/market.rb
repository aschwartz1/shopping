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

  def total_inventory
    total_inventory = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        total_inventory[item] ||= { quantity: 0, vendors: [] }
        total_inventory[item][:quantity] += quantity
        total_inventory[item][:vendors] << vendor
      end
    end

    total_inventory
  end

  def overstocked_items
    total_inventory.map do |item, info|
      item if overstocked?(info)
    end.compact
  end

  private

  def overstocked?(item_info)
    item_info[:vendors].length > 1 && item_info[:quantity] > 50
  end
end
