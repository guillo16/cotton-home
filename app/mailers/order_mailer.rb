class OrderMailer < ApplicationMailer
  def new_order
    @order = params[:order]

    mail(to: ENV["ADMIN_EMAIL"], subject: "Tienes una nueva orden!")
  end

  def new_payment
    @order = params[:order]
    user = @order.user.email
    mail(to: user, subject: "Compra realizada con exito!")
  end

  def new_payment_pending
    @order = params[:order]
    user = @order.user.email
    mail(to: user, subject: "Compra realizada con pago pendiente")
  end
end
