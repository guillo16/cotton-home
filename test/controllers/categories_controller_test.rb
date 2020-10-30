require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @category = categories(:sheets)
    @category_params = {
      name: "Hogar",
      photo: "url"
    }
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

  test "create should be a success" do
    assert_difference "Category.count", 1 do
      post categories_url, params: { category: @category_params }
    end

    assert_redirected_to categories_path
  end

  test "update should be a success" do
    assert_difference "Category.count", 1 do
      post categories_url, params: { category: @category_params }
    end

    assert_redirected_to categories_path
  end

  test "create should not be a success if name is not present" do
    assert_no_difference("Category.count", 0) do
      post categories_url, params: {
        category: {
          photo: "url",
        },
      }
    end
  end

  test "create should not be a success if photo is not present" do
    assert_no_difference("Category.count", 0) do
      post categories_url, params: {
        category: {
          name: "Sabanas",
        },
      }
    end
  end

  test "Admin should be able to update a category" do
    patch category_path(@category.id), params: {
      category: { name: "Sabanas" },
    }

    assert_equal "Sabanas", Category.find(@category.id).name
  end

  test "admin should not be able to update category if name already exists" do
    @category_params[:name] = "Cubrecamas"
    patch category_path(@category.id), params: {
      category: @category_params,
    }

    assert_equal "Colchas", Category.find(@category.id).name
  end

  test "admin should not be able to destroy a category" do
    assert_no_difference "Category.count", "The category should not be destroyed" do
      delete category_path(@category)
    end
  end

  test "super_admin should be able to destroy a category" do
    login_as users(:super_admin)
    assert_difference "Category.count", -1 do
      delete category_path(@category)
    end
  end
end
