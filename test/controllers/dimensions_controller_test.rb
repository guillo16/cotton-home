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
    get dimension_path(@dimension)

    assert_response :success
  end

  test "wholesaler should not get show" do
    login_as users(:wholesaler)
    get dimension_path(@dimension)

    assert_response :redirect
  end

  test "buyer should not get show" do
    login_as users(:buyer)
    get dimension_path(@dimension)

    assert_response :redirect
  end

  test "admin should get new" do
    get new_article_dimension_url(@article.id)

    assert_response :success
  end


  test "buyer should not get new" do
    login_as users(:buyer)

    get new_article_dimension_url(@article.id)

    assert_response :redirect
  end

  test "wholesaler should not get new" do
    login_as users(:wholesaler)

    get new_article_dimension_url(@article.id)

    assert_response :redirect
  end

  test "create should be success" do
    assert_difference "Dimension.count", 1 do
      post article_dimensions_url(@article.id), params: { dimension: @dimension_params }
    end

    assert_redirected_to article_path(@article)
  end

  test "admin should get edit" do
    get edit_dimension_path(@dimension)

    assert_response :success
  end

  test "buyer should not get edit" do
    login_as users(:buyer)
    get edit_dimension_path(@dimension)

    assert_response :redirect
  end

  test "wholesaler should not get edit" do
    login_as users(:wholesaler)
    get edit_dimension_path(@dimension)

    assert_response :redirect
  end

  test "update should be success" do
    patch dimension_path(@dimension), params: { dimension: { size: "small" } }

    assert_redirected_to dimension_path(@dimension)
    @dimension.reload

    assert_equal "small", @dimension.size
  end

  test "destroy should be success" do
    assert_difference("Dimension.count", -1) do
      delete dimension_path(@dimension)
    end

    assert_redirected_to article_path(@article)
  end

end
