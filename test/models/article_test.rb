require 'test_helper'

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
end
