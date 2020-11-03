class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if current_user.permission_level == "admin" || current_user.permission_level == "super_admin"
      @categories = Category.all
    else
      redirect_to root_path
    end
  end

  def show
    categories = @category.sub_categories
    @products = Product.where(sub_category_id: categories)
  end

  def new
    if current_user.permission_level == "admin"
      @category = Category.new
    else
      redirect_to root_path
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      render :new
    end
  end

  def destroy
    return unless current_user.permission_level == "super_admin"

    @category.destroy
    redirect_to root_path
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :photo)
  end
end
