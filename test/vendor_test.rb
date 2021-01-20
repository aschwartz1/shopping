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
end
