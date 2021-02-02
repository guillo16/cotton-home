require 'test_helper'

class DimensionTest < ActiveSupport::TestCase
  setup do
    @article = articles(:pillow)
    @dimension = Dimension.new(size: "Twin", description: "Very nice",
                               price: 3435,
                               clarification: "very soft",
                               article: @article
                              )
  end

  test "should be valid if all fields are set" do
    assert @dimension.valid?
  end

  test "should be invalid if size is not present" do
    @dimension.size = nil
    assert_not @dimension.valid?
  end

  test "should be invalid if description is not present" do
    @dimension.description = nil
    assert_not @dimension.valid?
  end

  test "should be invalid if price is not present" do
    @dimension.price = nil
    assert_not @dimension.valid?
  end
end
