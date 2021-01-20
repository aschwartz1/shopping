require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require './lib/item'

class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new('Roadside Stand')
    @peach = Item.new({name: 'Peach', price: '$0.75'})
    @tomato = Item.new({name: 'Tomato', price: '$0.5'})
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_readable_attributes
    assert_equal 'Roadside Stand', @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_can_check_stock
    assert_equal 0, @vendor.check_stock(@peach)
  end

  def test_can_stock
    @vendor.stock(@peach, 30)
    @vendor.stock(@tomato, 15)

    assert_equal 30, @vendor.check_stock(@peach)
    assert_equal 15, @vendor.check_stock(@tomato)

    @vendor.stock(@peach, 5)
    assert_equal 35, @vendor.check_stock(@peach)
  end

  def test_potential_revenue
    @vendor.stock(@peach, 30)
    @vendor.stock(@tomato, 15)

    assert_equal 30, @vendor.potential_revenue
  end

  def test_can_tell_if_it_sells_something
    @vendor.stock(@peach, 30)

    assert_equal true, @vendor.sells?('Peach')
    assert_equal false, @vendor.sells?('Chard')
  end

  def test_can_tell_items_sold
    @vendor.stock(@tomato, 15)
    @vendor.stock(@peach, 30)

    assert_equal ['Peach', 'Tomato'], @vendor.item_names
  end

  def test_can_sell
    @vendor.stock(@tomato, 15)

    @vendor.sell(@tomato, 10)

    assert_equal 5, @vendor.check_stock(@tomato)
  end

  def test_cannot_sell_more_than_have
    skip
    # TODO: implement this guard
  end
end
