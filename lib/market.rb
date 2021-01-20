require 'time'

class Market
  attr_reader :name,
              :vendors,
              :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = today_as_string
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

  # TODO: I know this method needs work, but I'm out of time
  def sell(item, quantity)
    return false if total_inventory[item][:quantity] < quantity

    left_to_sell = quantity
    total_inventory[item][:vendors].each do |vendor|
      amount_to_sell = vendor_can_sell(left_to_sell, vendor, item)
      vendor.sell(item, amount_to_sell)
      left_to_sell -= amount_to_sell
    end

    true
  end

  # TODO: I know this method needs work, but I'm out of time
  def vendor_can_sell(amount_needing_to_sell, vendor, item)
    vendor_stock = vendor.check_stock(item)
    return vendor_stock if amount_needing_to_sell > vendor_stock
    amount_needing_to_sell
  end

  private

  def overstocked?(item_info)
    item_info[:vendors].length > 1 && item_info[:quantity] > 50
  end

  def today_as_string
    Date.today.strftime('%d/%m/%Y')
  end
end
