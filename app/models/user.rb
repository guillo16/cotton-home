class User < ApplicationRecord
  enum permission_level: { buyer: 0, wholesaler: 1, admin: 2, super_admin: 3 }

  after_create :send_welcome_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :payments
  has_one :shipping, dependent: :destroy

  def user_is_admin?
    self.permission_level == "admin" || self.permission_level == "super_admin"
  end

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
