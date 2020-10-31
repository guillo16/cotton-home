class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_product, only: %i[show update destroy]

  def index
    if current_user.permission_level == "admin" || current_user.permission_level == "super_admin"
      @products = Product.order(name: :asc)
    else
      redirect_to root_path
    end
  end

  def show
    @variant = Variant.new
  end

  def new
    if current_user.permission_level == "admin" || current_user.permission_level == "super_admin"
      @product = Product.new
    else
      redirect_to root_path
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
    if current_user.permission_level == "admin" || current_user.permission_level == "super_admin"
      @product = Product.friendly.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    return unless current_user.permission_level == "admin" || current_user.permission_level == "super_admin"

    @product.destroy
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :photo, :sub_category_id)
  end
end
