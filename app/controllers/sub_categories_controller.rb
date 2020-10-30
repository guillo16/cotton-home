class SubCategoriesController < ApplicationController
  before_action :set_sub_category, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @categories = SubCategory.all
  end

  def show; end

  def new
    if current_user.permission_level == "admin" || current_user.permission_level == "super_admin"
      @sub_category = SubCategory.new
    else
      redirect_to root_path
    end
  end

  def create
    @sub_category = SubCategory.new(sub_category_params)
    if @sub_category.save
      redirect_to sub_categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @sub_category.update(sub_category_params)
      redirect_to sub_category_path(@sub_category)
    else
      render :new
    end
  end

  def destroy
    return unless current_user.permission_level == "admin" || current_user.permission_level == "super_admin"

    @sub_category.destroy
    redirect_to root_path
  end

  private

  def set_sub_category
    @sub_category = SubCategory.friendly.find(params[:id])
  end

  def sub_category_params
    params.require(:sub_category).permit(:name, :category_id)
  end
end
