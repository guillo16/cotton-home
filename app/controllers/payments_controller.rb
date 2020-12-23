class PaymentsController < ApplicationController
  before_action :set_order, only: %i[new create]
  def new
    @order = current_user.orders.where(state: 'Pendientes').find(params[:order_id])
  end

  def create
    @cart = Cart.find(session[:cart_id])
    session[:cart_id] = nil
    @order.update(state: 'Encargado')
    OrderMailer.with(order: @order).new_order.deliver_later
    redirect_to order_path(@order)
    # OrderMailer.with(order: @order).new_order.deliver_later
    # OrderMailer.with(order: @order).new_payment.deliver_later
  end

  private

  def set_order
    @order = current_user.orders.where(state: 'Pendientes').find(params[:order_id])
  end
end
