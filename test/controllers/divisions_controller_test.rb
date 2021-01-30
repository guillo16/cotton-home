require 'test_helper'

class DivisionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as users(:admin)
    @division = divisions(:sheets)
    @division_params = { name: "Sheets two" }
  end

  test "should get index if you login as admin" do
    get divisions_path

    assert_response :success
  end

  test "should not get index if you login as buyer" do
    login_as users(:buyer)
    get divisions_path

    assert_response :redirect
  end

  test "should not get index if you login as wholesaler" do
    login_as users(:wholesaler)
    get divisions_path

    assert_response :redirect
  end

  test "wholesaler should get show page" do
    login_as users(:wholesaler)
    get division_path(@division)

    assert_response :success
  end

  test "admin should get show page" do
    get division_path(@division)

    assert_response :success
  end

  test "buyer should not get show page" do
    login_as users(:buyer)
    get division_path(@division)

    assert_response :redirect
  end

  test "admin should get new" do
    get new_division_path

    assert_response :success
  end

  test "buyer should not get new" do
    login_as users(:buyer)
    get new_division_path

    assert_response :redirect
  end

  test "wholesaler should not get new" do
    login_as users(:wholesaler)
    get new_division_path

    assert_response :redirect
  end

  test "admin should create a division" do
    assert_difference "Division.count", 1 do
      post divisions_url, params: {
        division: { name: "Sabanas" }
      }
    end
  end

  test "admin should not create a division if name is nil" do
    assert_no_difference "Division.count", 0 do
      post divisions_url, params: {
        division: { name: nil }
      }
    end
  end

  test "admin should get edit" do
    get edit_division_path(@division)

    assert_response :success
  end

  test "buyer should not get edit" do
    login_as users(:buyer)
    get edit_division_path(@division)

    assert_response :redirect
  end

  test "wholesaler should not get edit" do
    login_as users(:wholesaler)
    get edit_division_path(@division)

    assert_response :redirect
  end

  test "admin should update division" do
    patch division_path(@division) , params: {
      division: { name: "sheet three"}
    }

    assert_equal "sheet three", Division.find(@division.id).name
  end


  test "superadmin should delete division" do
    login_as users(:super_admin)
    assert_difference "Division.count", -1 do
      delete division_path(@division)
    end
  end
end
