class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end

  def potential_revenue
    @inventory.sum do |item, quantity|
      item.price * quantity
    end
  end

  def sells?(item_name)
    items.any? do |item|
      item.name == item_name
    end
  end

  def item_names
    items.map do |item|
      item.name
    end.sort
  end

  private

  def items
    @inventory.keys
  end
end
