require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @division = divisions(:sheets)
    @article = articles(:pillow)
    @article_params = {
      name: "second_pillow",
      color: "red",
      photo: "something",
      division_id: @division.id
    }
  end

  test "wholesaler should get index" do
    login_as users(:wholesaler)

    get articles_path

    assert_response :success
  end

  test "admin should get index" do
    login_as users(:admin)

    get articles_path

    assert_response :success
  end

  test "super_admin should get index" do
    login_as users(:super_admin)

    get articles_path

    assert_response :success
  end

  test "buyer should not get index" do
    login_as users(:buyer)

    get articles_path

    assert_response :redirect
  end

  test "wholesaler should get show" do
    login_as users(:wholesaler)

    get article_path(@article)

    assert_response :success
  end

  test "admin should get show" do
    login_as users(:admin)

    get article_path(@article)

    assert_response :success
  end

  test "super_admin should get show" do
    login_as users(:super_admin)

    get article_path(@article)

    assert_response :success
  end

  test "buyer should not get show" do
    login_as users(:buyer)

    get article_path(@article)

    assert_response :redirect
  end

  test "admin should get new" do
    get new_article_path

    assert_response :success
  end

  test "wholesaler should not get new" do
    login_as users(:wholesaler)

    get new_article_path

    assert_response :redirect
  end

  test "admin should get edit" do
    get edit_article_path(@article)

    assert_response :success
  end

end
