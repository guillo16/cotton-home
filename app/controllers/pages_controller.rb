class PagesController < ApplicationController
  before_action :set_sub_category, only: %i[home search]
  skip_before_action :authenticate_user!, only: %i[home search result]

  def home
    @products = Product.all
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

  private

  def set_sub_category
    @sub_categories = SubCategory.all
  end
end
