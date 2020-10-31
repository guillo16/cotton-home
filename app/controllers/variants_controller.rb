class VariantsController < ApplicationController
  before_action :set_variant, only: %i[show edit update destroy]
  def show
  end

  def create
    @product = Product.find(params[:product_id])
    @variant = Variant.new(variant_params)
    @variant.product = @product
    if @variant.save
      redirect_to product_path(@product)
    else
      render 'products/show'
    end
  end

  def edit
  end

  def update
    @variant.update(variant_params)
    redirect_to variant_path(@variant)
  end

  def destroy
    @variant.destroy
    redirect_to products_path
  end

  private

  def set_variant
    @variant = Variant.find(params[:id])
  end

  def variant_params
    params.require(:variant).permit(:size, :price_cents, :stock)
  end
end
