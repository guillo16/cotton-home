class VariantsController < ApplicationController
  before_action :set_variant, only: %i[show edit update destroy]
  before_action :set_product, only: %i[new create]
  def show; end

  def new
    if user_has_permission_level?
      @variant = Variant.new
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def create
    @variant = Variant.new(variant_params)
    @variant.product = @product
    if @variant.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @variant.update(variant_params)
      redirect_to variant_path(@variant)
    else
      render :edit
    end
  end

  def destroy
    @variant.destroy
    redirect_to product_path(@variant.product)
  end

  private

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def set_variant
    if user_has_permission_level?
      @variant = Variant.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def variant_params
    params.require(:variant).permit(:size, :price_cents, :stock)
  end
end
