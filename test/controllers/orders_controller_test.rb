require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @cart = carts(:first_cart)
    @user = users(:buyer)
    @order = orders(:first_order)
    @order_params = {
                      state: "Encargado",
                      amount_cents: 20334,
                      checkout_session_id: 122,
                      user: @user,
                      cart: @cart
                    }
  end

  test "admin should get index" do
    get orders_path

    assert_response :success
  end

  test "buyer should not get index" do
    login_as users(:buyer)

    get orders_path

    assert_response :redirect
  end

end


