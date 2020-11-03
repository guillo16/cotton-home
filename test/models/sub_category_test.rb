require 'test_helper'

class SubCategoryTest < ActiveSupport::TestCase
  setup do
    @sub_category = SubCategory.new(
      name: "Sabanas",
      category: categories(:sheets)
    )
  end

  test "should be valid if all fields are set" do
    assert @sub_category.valid?
  end

  test "should ve invalid if name is not present" do
    @sub_category.name = nil

    assert_not @sub_category.valid?
  end

  # test "should ve invalid if name already exists" do
  #   @sub_category.name = "pillow"

  #   assert_not @sub_category.valid?
  # end

  test "should ve invalid if category is not present" do
    @sub_category.category_id = nil

    assert_not @sub_category.valid?
  end
end
