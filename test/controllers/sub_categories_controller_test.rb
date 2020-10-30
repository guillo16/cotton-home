require 'test_helper'

class SubCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @category = categories(:sheets)
    @sub_category = sub_categories(:towel)
    @sub_category_params = {
      name: "Hogar",
      category: @category
    }
  end

  test "user should see show page" do
    login_as users(:buyer)

    get sub_category_path(@category)

    assert_response :success
  end

  test "user should not see new sub category page" do
    login_as users(:super_admin)

    get new_sub_category_path

    assert_response :redirect
  end
end
