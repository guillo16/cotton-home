require 'test_helper'

class ShippingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
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
      user_id: users(:buyer),
      order_id: @order.id,
    }
  end

  test "create should be a success" do
    assert_difference "Shipping.count", 1 do
      post order_shippings_url(@order), params: { shipping: @shipping_params }
    end
  end

  # test "buyer should be able to update product" do
  #   patch shipping_path(@shipping.id), params: {
  #     shipping: {
  #       address: "Cariola y Universo",
  #       user_id: users(:buyer).id,
  #       order_id: @order.id
  #     }
  #   }
  #   binding.pry
  #   assert_equal "Cariola y Universo", Shipping.find(@shipping.id).address
  # end
end
