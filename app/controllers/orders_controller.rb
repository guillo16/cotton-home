class OrdersController < ApplicationController
  def index
    if user_has_permission_level?
      @order = Order.where(state: 'Encargado').sum('amount_cents') * 0.01
      @orders = Order.where(state: 'Encargado').order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def show
    @order = current_user.orders.where(state: 'Encargado').friendly.find(params[:id])
  end

  def create
    cart = Cart.find(params[:cart_id])
    order = Order.create!(amount: cart.total_price,
                          state: 'Pendientes',
                          user: current_user,
                          cart: cart, total: cart.total_price, checkout_session_id: SecureRandom.hex)
    redirect_to new_order_payment_path(order)
  end
end
