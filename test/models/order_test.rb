require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @user = users(:buyer)
    @cart = carts(:first_cart)
    @order = Order.new(state: "pending", amount_cents: 2334, checkout_session_id: 12234, user: @user, cart: @cart)
  end

  test "should be valid" do
    assert @order.valid?
  end

  test "should be invalid if cart is not present" do
    @order.cart = nil

    assert_not @order.valid?
  end

  test "should be invalid if user is not present" do
    @order.user = nil

    assert_not @order.valid?
  end
end
