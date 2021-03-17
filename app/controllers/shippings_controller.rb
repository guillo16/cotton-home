class ShippingsController < ApplicationController
  before_action :set_shipping, only: %w[edit update]

  def create
    @order = Order.friendly.find(params[:order_id])
    @shipping = Shipping.new(shipping_params)
    @shipping.order = @order
    @shipping.user = current_user
    if @shipping.save
      if @shipping.shipping_method == 'one'
        @shipping.amount = 500
      elsif @shipping.shipping_method == 'two'
        @shipping.amount = 600
      elsif @shipping.shipping_method == 'three'
        @shipping.amount = 700
      else
        @shipping.amount = 0
      end
      @order.update(total: @order.total.to_i + @shipping.amount)
      redirect_to new_order_payment_path(@order)
    else
      render 'payments/new'
    end
  end

  def edit; end

  def update
    if @shipping.update(shipping_params)
      if @shipping.shipping_method == 'one'
        @shipping.amount = 500
      elsif @shipping.shipping_method == 'two'
        @shipping.amount = 600
      elsif @shipping.shipping_method == 'three'
        @shipping.amount = 700
      else
        @shipping.amount = 0
      end
      @shipping.order.update(total: @shipping.order.amount.to_i + @shipping.amount)
      redirect_to new_order_payment_path(@shipping.order.id)
    else
      render :edit
    end
  end

  private

  def shipping_params
    params.require(:shipping).permit(:address,
                                     :area_code,
                                     :building,
                                     :city,
                                     :dni,
                                     :floor,
                                     :first_name,
                                     :last_name,
                                     :number,
                                     :phone,
                                     :postal_code,
                                     :shipping_method,
                                     :state
                                    )
  end

  def set_shipping
    @shipping = Shipping.find(params[:id])
  end
end
