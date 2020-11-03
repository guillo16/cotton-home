require 'test_helper'

class VariantTest < ActiveSupport::TestCase
  setup do
    login_as users(:admin)
    @product = products(:sheets)
    @variant = Variant.new(
      size: "M",
      stock: 3,
      price_cents: 323,
      product_id: @product.id
    )
  end

  test "should be valid if all fields are set" do
    assert @variant.valid?
  end

  test "should be invalid if size is not present" do
    @variant.size = nil

    assert_not @variant.valid?
  end

  test "should be invalid if size is already taken" do
    @variant.size = "L"

    assert_not @variant.valid?
  end

  test "should be invalid if stock is not present" do
    @variant.stock = nil

    assert_not @variant.valid?
  end

  test "should be invalid if price is not present" do
    @variant.price_cents = nil

    assert_not @variant.valid?
  end
end
