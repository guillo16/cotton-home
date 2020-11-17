require 'test_helper'
require "open-uri"

class ProductTest < ActiveSupport::TestCase
  setup do
    login_as users(:admin)
    @sub_category = sub_categories(:pillow)
    @product = Product.new(
      name: "Sabanas",
      sub_category_id: @sub_category.id
      )
  file = URI.open("http://res.cloudinary.com/demo/image/upload/sample.jpg")
  @product.photos.attach(io: file, filename: 'image.jpg')
  end

  test "should be valid if all fields are set" do
    assert @product.valid?
  end

  test "should be invalid if name is not present" do
    @product.name = nil

    assert_not @product.valid?
  end

  test "should be invalid if photo is not present" do
    @product.photos = nil

    assert_not @product.valid?
  end
end
