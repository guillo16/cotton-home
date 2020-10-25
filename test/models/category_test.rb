require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = Category.new( name: "Sabanas", photo: "url")
  end

  test "should be valid if all fields are set" do
    assert @category.valid?
  end

  test "should be invalid if name is not present" do
    @category.name = nil

    assert_not @category.valid?
  end

  test "should be invalid if name  is not unique" do
    @category.name = "Colchas"

    assert_not @category.valid?
  end

  test "should be invalid if photo is not present" do
    @category.photo = nil

    assert_not @category.valid?
  end
end
