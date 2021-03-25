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
    headers = { 'accept': 'application/json', 'content-type': 'application/json' }
    payment_attempt = JSON.parse(headers).body
    p payment_attempt
    @payment = Payment.new(payment_params)
    @payment.order = @order
    @payment.save
    @order.update(state: 'Encargado')
    @order.cart.line_items.each do |item|
      line_quantity = item.quantity
      item.variant.decrement!(:stock, line_quantity)
    end
    redirect_to order_path(@order)
  end

  private

  def set_order
    @order = current_user.orders.where(state: 'Pendientes').friendly.find(params[:order_id])
  end

  def payment_params
    params.permit(:back_url, :payment_type, :payment_status, :processing_mode, :merchant_order_id, :merchant_account_id, :authenticity_token, :payment_status_detail)
  end
end
