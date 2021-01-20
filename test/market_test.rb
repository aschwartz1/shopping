require 'minitest/autorun'
require 'minitest/pride'
require './lib/market'
require './lib/vendor'
require './lib/item'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new('Farmers Market')
    @garden_seller = Vendor.new('Fruits and Veggies')
    @jelly_seller = Vendor.new('The Preservation Room')
    @sample_seller = Vendor.new('Free Stuff')
    @peach = Item.new({name: 'Peach', price: '$0.75'})
    @tomato = Item.new({name: 'Tomato', price: '$0.5'})
    @jalepeno = Item.new({name: 'Jalepeno', price: '$0.25'})
    @peach_jelly = Item.new({name: 'Peach Jelly', price: '$1.00'})
    @pepper_jelly = Item.new({name: 'Pepper Jelly', price: '$1.25'})
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_readable_attributes
    assert_equal 'Farmers Market', @market.name
    assert_equal [], @market.vendors
  end

  def test_can_add_vendors
    @market.add_vendor(@garden_seller)
    @market.add_vendor(@jelly_seller)
    @market.add_vendor(@sample_seller)

    assert_equal [@garden_seller, @jelly_seller, @sample_seller], @market.vendors
  end

  def test_can_tell_vendor_names
    @market.add_vendor(@garden_seller)
    @market.add_vendor(@jelly_seller)

    assert_equal ['Fruits and Veggies', 'The Preservation Room'], @market.vendor_names
  end

  def test_can_find_vendors_that_sell_an_item
    @garden_seller.stock(@jalepeno, 10)
    @garden_seller.stock(@tomato, 20)
    @sample_seller.stock(@jalepeno, 5)
    @market.add_vendor(@garden_seller)
    @market.add_vendor(@sample_seller)

    assert_equal [@garden_seller, @sample_seller], @market.vendors_that_sell('Jalepeno')
    assert_equal [@garden_seller], @market.vendors_that_sell('Tomato')
    assert_equal [], @market.vendors_that_sell('Chard')
  end

  def test_sorted_item_list
    @garden_seller.stock(@jalepeno, 10)
    @garden_seller.stock(@tomato, 20)
    @sample_seller.stock(@jalepeno, 5)
    @sample_seller.stock(@peach_jelly, 5)
    @market.add_vendor(@garden_seller)
    @market.add_vendor(@sample_seller)

    expected = ['Jalepeno', 'Peach Jelly', 'Tomato']
    assert_equal expected, @market.sorted_item_list
  end

  def test_total_inventory
    @garden_seller.stock(@jalepeno, 10)
    @garden_seller.stock(@tomato, 20)
    @sample_seller.stock(@jalepeno, 5)
    @sample_seller.stock(@peach_jelly, 5)
    @market.add_vendor(@garden_seller)
    @market.add_vendor(@sample_seller)

    expected = {
      @jalepeno => {
        quantity: 15,
        vendors: [@garden_seller, @sample_seller]
      },
      @tomato => {
        quantity: 20,
        vendors: [@garden_seller]
      },
      @peach_jelly => {
        quantity: 5,
        vendors: [@sample_seller]
      }
    }

    assert_equal expected, @market.total_inventory
  end
end
