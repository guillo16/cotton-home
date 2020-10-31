require 'test_helper'

class SubCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @category = categories(:sheets)
    @sub_category = sub_categories(:towel)
    @sub_category_params = {
      name: "algo",
      category_id: @category.id
    }
  end

  test "buyer should see show page" do
    login_as users(:buyer)

    get sub_category_path(@sub_category)

    assert_response :success
  end

  test "user should not see new sub category page" do
    login_as users(:buyer)

    get new_sub_category_path

    assert_response :redirect
  end

  test "super_admin should see new sub category page" do
    login_as users(:super_admin)

    get new_sub_category_path

    assert_response :success
  end

  test "create should be success" do
    assert_difference "SubCategory.count", 1 do
      post sub_categories_url, params: { sub_category: @sub_category_params }
    end

    assert_redirected_to sub_categories_path
  end

  test "create should not be success if name is not present" do
    assert_no_difference "SubCategory.count", 0 do
      post sub_categories_url, params: {
        sub_category: {
          category_id: @category.id
        }
      }
    end
  end

   test "create should not be success if category id is not present" do
    assert_no_difference "SubCategory.count", 0 do
      post sub_categories_url, params: {
        sub_category: {
          name: "Something"
        }
      }
    end
  end

  test "Admin should be able to update a sub_category" do
    patch sub_category_path(@sub_category.id), params: {
      sub_category: { name: "Remeras", category_id: @category.id },

    }
    assert_equal "Remeras", SubCategory.find(@sub_category.id).name
  end

  test "admin should be able to destroy a sub_category" do
    assert_difference "SubCategory.count", -1 do
      delete sub_category_path(@sub_category)
    end
  end

  test "buyer should not be able to destroy a sub_category" do
    login_as users(:buyer)
    assert_no_difference "SubCategory.count", 0 do
      delete sub_category_path(@sub_category)
    end
  end
end
