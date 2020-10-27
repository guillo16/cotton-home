require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @category = Category.new(
      name: "Hogar",
      photo: "url"
      )
  end

  test "buyer should be able to see all categories" do
    login_as users(:buyer)

    get categories_path

    assert_response :success
  end

  test "redirected if not admin" do
    login_as users(:buyer)

    get "/categories/new"

    assert_response :redirect
  end

  test "admin should be able to create new category" do
    get "/categories/new"

    assert_response :success
  end

end
