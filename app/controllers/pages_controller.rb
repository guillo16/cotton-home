class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @products = Product.all
    @sub_categories = SubCategory.all
  end
end
