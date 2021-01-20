require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @peach = Item.new({name: 'Peach', price: '$0.75'})
  end

  def test_it_exists
    assert_instance_of Item, @peach
  end

  def test_readable_attributes
    assert_equal 'Peach', @peach.name
    assert_equal 0.75, @peach.price
  end
end
