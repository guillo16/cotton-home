require 'test_helper'
require "open-uri"

class ArticleTest < ActiveSupport::TestCase
  setup do
    login_as users(:admin)
    @division = divisions(:sheets)
    @article = Article.new( name: "pillow_second", color: "red", division_id: @division.id)
    file = URI.open("http://res.cloudinary.com/demo/image/upload/sample.jpg")
    @article.photos.attach(io: file, filename: 'image.jpg')
  end

  test "should be valid if all fields are set" do
    assert @article.valid?
  end

  test "should be invalid if name is not present" do
    @article.name = nil

    assert_not @article.valid?
  end


  test "should be invalid if photo is not present" do
    @article.photos = nil

    assert_not @article.valid?
  end
end
