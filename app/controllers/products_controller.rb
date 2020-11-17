class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_product, only: %i[show update destroy]

  def index
    if user_has_permission_level?
      @products = Product.includes(:sub_category).order(sub_category_id: :asc).order(name: :asc).paginate(page: params[:page], per_page: 20)
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def show; end

  def new
    if user_has_permission_level?
      @product = Product.new
    else
      flash[:notice] = "Accesso denegado!"
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
    if user_has_permission_level?
      @product = Product.friendly.find(params[:id])
    else
      flash[:notice] = "Accesso denegado!"
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
    return unless user_has_permission_level?

    @product.destroy
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :sub_category_id, photos: [])
  end
end
