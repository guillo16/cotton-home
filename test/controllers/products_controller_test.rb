require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @sub_category = sub_categories(:pillow)
    @product = products(:sheets)
    @product_params = {
      name: "Colchas",
      photo: "url",
      sub_category_id: @sub_category.id
    }
  end

  test "buyer should see show page" do
    login_as users(:buyer)

    get product_path(@product)

    assert_response :success
  end

  test "buyer should not get new product page" do
    login_as users(:buyer)

    get new_product_path

    assert_response :redirect
  end

  test "admin should create a product page" do
    assert_difference "Product.count", 1 do
      post products_url, params: { product: @product_params }
    end
    product = Product.last

    assert_redirected_to product_path(product)
  end

  test "create should not be success if name is not present " do
    assert_no_difference "Product.count", 0 do
      post products_url, params: {
        product: {
          photo: "url",
          sub_category_id: @sub_category.id
        }
      }
    end
  end

  test "create should not be success if photo is not present " do
    assert_no_difference "Product.count", 0 do
      post products_url, params: {
        product: {
          name: "Sabanas",
          sub_category_id: @sub_category.id
        }
      }
    end
  end

  test "admin should be able to update product" do
    patch product_path(@product.id), params: {
      product: {
        name: "Sabanas king size",
        photo: "url",
        sub_category_id: @sub_category.id
      }
    }
    assert_equal "Sabanas king size", Product.find(@product.id).name
  end

  test "admin should be able to destroy a sub_category" do
    assert_difference "Product.count", -1 do
      delete product_path(@product)
    end
  end

  test "buyer should not be able to destroy a product" do
    login_as users(:buyer)
    assert_no_difference "Product.count", 0 do
      delete product_path(@product)
    end
  end
end
