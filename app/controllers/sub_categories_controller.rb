class SubCategoriesController < ApplicationController
  before_action :set_sub_category, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @categories = SubCategory.all
  end

  def show; end

  def new
    @sub_category = SubCategory.new
  end

  def create
    @sub_category = SubCategory.new(sub_category_params)
    if @sub_category.save
      redirect_to sub_category_path(@sub_category)
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
    @sub_category.destroy
    redirect_to root_paths
  end

  private

  def set_sub_category
    @sub_category = SubCategory.find(params[:id])
  end

  def sub_category_params
    params.require(:category).permit(:title, :category_id)
  end
end
