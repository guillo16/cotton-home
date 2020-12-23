class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @products = Product.all
    @sub_categories = SubCategory.all
  end

  def search; end

  def result
    if params[:query].present?
      sql_query = " \
      products.name @@ :query \
      OR sub_categories.name @@ :query \
      "
      @products = Product.joins(:sub_category).where(sql_query, query: "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end
end
