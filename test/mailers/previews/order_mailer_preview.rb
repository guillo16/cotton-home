# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/new_order
  def new_order
    order = Order.first
    OrderMailer.with(order: order).new_order
  end

  def new_payment
    order = Order.first
    OrderMailer.with(order: order).new_payment
  end
end
