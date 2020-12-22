class SubCategoriesController < ApplicationController
  before_action :set_sub_category, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if user_has_permission_level?
      @sub_categories = SubCategory.includes(:category).order(category_id: :asc).order(name: :asc)
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def show
    @products = @sub_category.products
    if params["color"]
      @products = @sub_category.products.where(color: params["color"])
    else
      @products
    end
    @categories = Category.all
    @sub_categories = SubCategory.order(name: :asc)
  end

  def new
    if user_has_permission_level?
      @sub_category = SubCategory.new
    else
      flash[:notice] = "Accesso denegado!"
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
      redirect_to sub_categories_path
    else
      render :new
    end
  end

  def destroy
    return unless user_has_permission_level?

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
