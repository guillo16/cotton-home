class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_line_item, only: %i[show update destroy]
  before_action :set_cart, only: :create

  def show; end

  def new
    @line_item = LineItem.new
  end

  def create
    product = Product.find(params[:product_id])
    variant = Variant.find(params[:variant_id])
    @line_item = @cart.add_car(product, variant)
    if @line_item.save
      redirect_to @line_item.cart, notice: "Agregaste #{@line_item.product.name} al carrito"
    else
      render 'product/show'
    end
  end

  def update
    @line_item.update(line_item_params)
    redirect_to cart_path(@line_item.cart, anchor: @line_item.id.to_s)
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: 'Articulo removido' }
      format.json { head :no_content }
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:product_id, :variant_id, :quantity)
  end
end
