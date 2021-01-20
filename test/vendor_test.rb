require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new('Roadside Stand')
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_readable_attributes
    assert_equal 'Roadside Stand', @vendor.name
    assert_equal ({}), @vendor.inventory
  end
end
