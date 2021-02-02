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
      product: @product
    }
  end

  test "admin should get new view" do
    get new_product_variant_url(@product)

    assert_response :success
  end

  test "buyer should not get new view" do
    login_as users(:buyer)

    get new_product_variant_url(@product)

    assert_response :redirect
  end

   test "create should be success" do
    assert_difference "Variant.count", 1 do
      post product_variants_url(@product), params: { variant: @variant_params }
    end

    assert_redirected_to product_path(@product)
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
