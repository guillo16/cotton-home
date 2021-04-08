require 'test_helper'

class ShippingTest < ActiveSupport::TestCase
  setup do
    @user = users(:buyer)
    @order = orders(:first_order)
    @shipping = Shipping.new( address: "Ruben dario",
      area_code: 123,
      building: "5a",
      city: "Yerba Buena",
      dni: "32323232",
      floor: 5,
      first_name: "Benjamin",
      last_name: "Carlos",
      number: 154,
      order: @order,
      phone: 5888888,
      postal_code: 3245,
      shipping_method: "one",
      state: "Tucuman",
      user: @user
      )
  end

  test "should be valid if all fields are set" do
    assert @shipping.valid?
  end

  test "should be invalid if address is not set" do
    @shipping.address = nil

    assert_not @shipping.valid?
  end

  test "should be invalid if area code is not set" do
    @shipping.area_code = nil

    assert_not @shipping.valid?
  end

  test "should be invalid if area code is too short" do
    @shipping.area_code = 1

    assert_not @shipping.valid?
  end

  test "should be invalid if area code is too long" do
    @shipping.area_code = 123456

    assert_not @shipping.valid?
  end

  test "should be invalid if area code is not a number" do
    @shipping.area_code = "abc"

    assert_not @shipping.valid?
  end

  test "should be valid even if building is not set" do
    @shipping.building = nil

    assert @shipping.valid?
  end

  test "should be invalid if building is too long" do
    @shipping.building = "abcdefghijq"

    assert_not @shipping.valid?
  end

  test "should be invalid if city is not set" do
    @shipping.city = nil

    assert_not @shipping.valid?
  end

  test "should be invalid if dni is not set" do
    @shipping.dni = nil

    assert_not @shipping.valid?
  end

  test "should be invalid if dni too short" do
    @shipping.dni = 123456

    assert_not @shipping.valid?
  end

  test "should be invalid if dni too long" do
    @shipping.dni = 123456789

    assert_not @shipping.valid?
  end

  test "should be invalid if floor is to long" do
    @shipping.floor = 123

    assert_not @shipping.valid?
  end

  test "should be valid even if floor is not set" do
    @shipping.floor = nil

    assert @shipping.valid?
  end

  test "should be invalid if first_name is not set" do
    @shipping.first_name = nil

    assert_not @shipping.valid?
  end

  test "should be invalid if first_name too short" do
    @shipping.first_name = "a"

    assert_not @shipping.valid?
  end

  test "should be invalid if first_name too long" do
    @shipping.first_name = "a very very long first name"

    assert_not @shipping.valid?
  end

  test "should be invalid if last_name is not set" do
    @shipping.last_name = nil

    assert_not @shipping.valid?
  end

  test "should be invalid if last_name too short" do
    @shipping.last_name = "a"

    assert_not @shipping.valid?
  end

  test "should be invalid if last_name too long" do
    @shipping.last_name = "a very very long first name"

    assert_not @shipping.valid?
  end

  test "should be invalid if number is not set" do
    @shipping.number = nil

    assert_not @shipping.valid?
  end

end
