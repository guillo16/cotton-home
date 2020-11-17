class OrdersController < ApplicationController
  def show
    @order = current_user.orders.where(state: 'Encargado').find(params[:id])
  end

  def create
    cart = Cart.find(params[:cart_id])
    order = Order.create!(amount: cart.total_price, state: 'Pendientes', user: current_user, cart: cart)
    order.cart.line_items.each do |item|
      line_quantity = item.quantity
      item.variant.decrement!(:stock, line_quantity)
    end
    redirect_to new_order_payment_path(order)
  end
end
