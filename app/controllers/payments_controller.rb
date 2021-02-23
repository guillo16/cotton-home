class PaymentsController < ApplicationController
  before_action :set_order, only: %i[new create]

  def index
    @payments = Payment.includes(:order).includes(:user)
  end

  def show
    @payment = Payment.find(params[:id])
  end

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
    @payment = Payment.new(payment_params)
    @payment.order = @order
    if params[:payment_status] == "approved"
      @cart = Cart.find(session[:cart_id])
      session[:cart_id] = nil
      @payment.save
      @order.update(state: 'Encargado')
      OrderMailer.with(order: @order).new_order.deliver_later
      OrderMailer.with(order: @order).new_payment.deliver_later
      redirect_to order_path(@order)
    else
      flash[:notice] = "Pago rechazado por favor intente de nuevo!"
      @payment.save
      redirect_to new_order_payment_path(@order)
    end
  end

  private

  def set_order
    @order = current_user.orders.where(state: 'Pendientes').friendly.find(params[:order_id])
  end

  def payment_params
    params.permit(:back_url, :payment_type, :payment_status, :processing_mode, :merchant_order_id, :merchant_account_id, :authenticity_token, :payment_status_detail)
  end
end
