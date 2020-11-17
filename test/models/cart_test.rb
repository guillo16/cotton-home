require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = Cart.new
  end

  test "should be valid if all fields are set" do
    assert @cart.valid?
  end
end
