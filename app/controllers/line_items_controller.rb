class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_line_item, only: %i[show edit update destroy]
  before_action :set_cart, only: :create

  def index
    @line_items = LineItem.all
  end

  def show; end

  def new
    @line_item = LineItem.new
  end

  def edit; end

  def create
    product = Product.find(params[:product_id])
    variant = Variant.find(params[:variant_id])
    @line_item = @cart.add_car(product, variant)
    if @line_item.save
      redirect_to @line_item.cart, notice: 'Item added to cart.'
    else
      render 'product/show'
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def decrease
    @line_item = LineItem.find(params[:id])
    @line_item.decrement!(:quantity)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'bajaste uno' }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def increase
    @line_item = LineItem.find(params[:id])
    @line_item.increment!(:quantity)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'update' }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @line_item.variant.increment!(:stock, @line_item.quantity)
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: 'Item successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:product_id, :variant_id)
  end
end
