class PaymentsController < ApplicationController
  before_action :set_order, only: %i[new create]

  def index
    if user_has_permission_level?
      @payments = Payment.includes(:order).order(created_at: :desc)
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def show
    if user_has_permission_level?
      @payment = Payment.find(params[:id])
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def new
    @shipping = Shipping.new
  end

  def create
    require 'mercadopago'
    mp = MercadoPago.new(ENV["ACCESS_TOKEN"])
    token = params[:token]
    installments = 1
    issuer_id = params[:issuer_id]

    payment = {}
    payment[:transaction_amount] = @order.total.to_i
    payment[:token] = token
    payment[:installments] = installments
    payment[:issuer_id] = issuer_id
    payment[:payer] = {
      email: current_user.email
    }

    payment_response = mp.post("/v1/payments", payment)
    @payment = Payment.new(payment_params)
    @payment.order = @order
    @payment.payment_status = payment_response["response"]["status"]

    if payment_response["status"] == "201" && payment_response["response"]["status"] == "approved"
      @cart = Cart.find(session[:cart_id])
      session[:cart_id] = nil
      @payment.save
      @order.update(state: 'Encargado')
      @order.cart.line_items.each do |item|
        line_quantity = item.quantity
        item.variant.decrement!(:stock, line_quantity)
      end
      OrderMailer.with(order: @order).new_order.deliver_later
      OrderMailer.with(order: @order).new_payment.deliver_later
      redirect_to order_path(@order)
    elsif payment_response["status"] == "201" && payment_response["response"]["status"] == "in_process"
      @cart = Cart.find(session[:cart_id])
      session[:cart_id] = nil
      @payment.save
      @order.update(state: 'Encargado')
      @order.cart.line_items.each do |item|
        line_quantity = item.quantity
        item.variant.decrement!(:stock, line_quantity)
      end
      OrderMailer.with(order: @order).new_order.deliver_later
      OrderMailer.with(order: @order).new_payment_pending.deliver_later
      redirect_to order_path(@order)
    else
      flash[:notice] = "Pago rechazado por favor intente de nuevo!"
      redirect_to new_order_payment_path(@order)
    end
  end

  private

  def set_order
    @order = current_user.orders.where(state: 'Pendientes').friendly.find(params[:order_id])
  end

  def payment_params
    params.permit(:payment_type, :payment_status, :processing_mode, :merchant_order_id, :merchant_account_id, :authenticity_token, :payment_status_detail)
  end
end
