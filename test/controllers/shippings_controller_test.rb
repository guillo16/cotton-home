require 'test_helper'

class ShippingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @user = users(:buyer)
    @order = orders(:first_order)
    @shipping = shippings(:first_shipping)
    @shipping_params = {
      address: "Ruben dario y Algo",
      area_code: 123,
      building: "6a",
      city: "Yerba Buena",
      dni: 31323232,
      floor: 5,
      first_name: "Joe",
      last_name: "Doe",
      number: 152,
      phone: 5888888,
      postal_code: 3245,
      shipping_method: "one",
      state: "Tucuman",
    }
  end

  test "create should be a success" do
    assert_difference "Shipping.count", 1 do
      post order_shippings_url(@order), params: { shipping: @shipping_params }
    end
  end

  # test "buyer should update shipping" do
  #   patch shipping_url(@shipping), params: { shipping: { address: "Cariola y Universo" } }

  #   binding.pry

  #   # Reload association to fetch updated data and assert that title is updated.
  #   @shipping.reload
  #   assert_equal "Cariola y Universo", @shipping.address
  # end


end
