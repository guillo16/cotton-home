require 'test_helper'

class VariantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @product = products(:sheets)
    @variant = variants(:large)
    @variant_params = {
      size: "XS",
      stock: 34,
      price_cents: 23,
      product_id: @product.id
    }
  end

  test "admin should get edit view" do
    get edit_variant_path(@variant)

    assert_response :success
  end

  test "buyer should not get edit view" do
    login_as users(:buyer)
    get edit_variant_path(@variant)

    assert_response :redirect
  end

end
