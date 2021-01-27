require 'test_helper'

class DimensionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get dimensions_new_url
    assert_response :success
  end

  test "should get create" do
    get dimensions_create_url
    assert_response :success
  end

end
