require 'minitest/autorun'
require 'minitest/pride'
require './lib/market'
require './lib/vendor'
require './lib/item'

class MarketTest < Minitest::Test
  def setup
    @farmers_market = Market.new('Farmers Market')
    @garden_seller = Vendor.new('Fruits and Veggies')
    @jelly_seller = Vendor.new('The Preservation Room')
    @peach = Item.new({name: 'Peach', price: '$0.75'})
    @tomato = Item.new({name: 'Tomato', price: '$0.5'})
    @jalepeno = Item.new({name: 'Jalepeno', price: '$0.25'})
    @peach_jelly = Item.new({name: 'Peach Jelly', price: '$1.00'})
    @pepper_jelly = Item.new({name: 'Pepper Jelly', price: '$1.25'})
  end

  def test_it_exists
    assert_instance_of Market, @farmers_market
  end
end
