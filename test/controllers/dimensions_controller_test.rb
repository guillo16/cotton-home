require 'test_helper'

class DimensionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @article = articles(:pillow)
    @dimension = dimensions(:first_dimension)
    @dimension_params = {
                          size: "King",
                          description: "Very nice and expensive",
                          price: 4535,
                          clarification: "very long",
                          article: @article
                        }
  end

  test "admin should get show" do
    get dimensions_path(@dimension)

    assert_response :success
  end

  test "wholesaler should not get show" do
    login_as users(:wholesaler)
    get dimensions_path(@dimension)

    assert_response :redirect
  end

  test "buyer should not get show" do
    login_as users(:buyer)
    get dimensions_path(@dimension)

    assert_response :redirect
  end

  test "admin should get new" do
    get new_dimension_path

    assert_response :success
  end
end
