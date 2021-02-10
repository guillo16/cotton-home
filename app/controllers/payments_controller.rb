
class PaymentsController < ApplicationController
  before_action :set_order, only: %i[new create]

  def new
    @order = current_user.orders.where(state: 'Pendientes').find(params[:order_id])
    require 'mercadopago.rb'
    mp = MercadoPago.new(ENV['ACCESS_TOKEN'])

    # Crea un objeto de preferencia

    preference_data = {
      "items": [
        {
          "title": "Mi Orden",
          "unit_price": @order.amount.to_i,
          "quantity": 1,
          "currency_id": "ARS"
        }
      ]
    }
    @preference = mp.create_preference(preference_data)
    @preference_id = @preference["response"]["id"]
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
      redirect_to new_order_payment_path(@order)
    end
    # OrderMailer.with(order: @order).new_order.deliver_later
    # OrderMailer.with(order: @order).new_payment.deliver_later
  end

  private

  def set_order
    @order = current_user.orders.where(state: 'Pendientes').find(params[:order_id])
  end
end
