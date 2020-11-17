require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  setup do
   @line_item = LineItem.new(
     product_id: products(:sheets).id,
     variant_id: variants(:large).id,
     cart_id: carts(:first_cart).id
    )
  end

  test "should be valid if all fields are set" do
    assert @line_item.valid?
  end

   test "should be invalid if quantity is not present" do
    @line_item.quantity = nil

    assert_not @line_item.valid?
  end

  test "should be invalid if product is not present" do
    @line_item.product_id = nil

    assert_not @line_item.valid?
  end

  test "should be invalid if variant is not present" do
    @line_item.variant_id = nil

    assert_not @line_item.valid?
  end

  test "should be invalid if cart is not present" do
    @line_item.cart_id = nil

    assert_not @line_item.valid?
  end
end
