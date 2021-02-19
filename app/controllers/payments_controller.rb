class PaymentsController < ApplicationController
  before_action :set_order, only: %i[new create]

  def new
    require 'mercadopago.rb'
    mp = MercadoPago.new(ENV['ACCESS_TOKEN'])
    # Crea un objeto de preferencia
    preference_data = {
      "items": [
        {
          "title": "Total",
          "unit_price": @order.total.to_i,
          "quantity": 1,
          "currency_id": "ARS"
        }
      ]
    }
    @preference = mp.create_preference(preference_data)
    @preference_id = @preference["response"]["id"]
    @shipping = Shipping.new
  end

  def create
    if params[:payment_status] == "approved"
      @cart = Cart.find(session[:cart_id])
      session[:cart_id] = nil
      @order.update(state: 'Encargado')
      OrderMailer.with(order: @order).new_order.deliver_later
      OrderMailer.with(order: @order).new_payment.deliver_later
      redirect_to order_path(@order)
    else
      flash[:notice] = "Pago rechazado por favor intente de nuevo!"
      redirect_to new_order_payment_path(@order)
    end
  end

  private

  def set_order
    @order = current_user.orders.where(state: 'Pendientes').find(params[:order_id])
  end
end
