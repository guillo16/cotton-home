class OrderMailer < ApplicationMailer
  def new_order
    @order = params[:order]

    mail(to: ENV["ADMIN_EMAIL"], subject: "Tienes una nueva orden!")
  end
end
