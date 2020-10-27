require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(
      email: "buyer2@mail.com",
      password: '123456',
      permission_level: "buyer",
    )
  end

  test "should be valid if all fields are set" do
    assert @user.valid?
  end

  test "should be invalid if email is not present" do
    @user.email = nil

    assert_not @user.valid?
  end

  test "should be invalid if password is not present" do
    @user.password = nil

    assert_not @user.valid?
  end

  test "should be invalid if user already exists" do
    @user.email = "buyer@mail.com"

    assert_not @user.valid?
  end
end
