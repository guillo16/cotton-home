require 'test_helper'
require "open-uri"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @division = divisions(:sheets)
    @article = articles(:pillow)
    @article_params = {
      name: "second_pillow",
      color: "red",
      photo: "guillo",
      division: @division.id
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

  test "admin should create an artilce" do
    assert_difference "Article.count", 1 do
      post articles_url, params: { article: @article_params }
    end


    assert_redirected_to article_path(article)
  end

  test "admin should be able to destroy a article" do
    assert_difference "Article.count", -1 do
      delete article_path(@article)
    end
  end

  test "buyer should not be able to destroy a article" do
    login_as users(:buyer)
    assert_no_difference "Article.count", 0 do
      delete article_path(@article)
    end
  end

end
