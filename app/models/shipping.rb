class Shipping < ApplicationRecord
  belongs_to :order
  belongs_to :user

  validates :address, presence: true
  validates :amount, presence: true
  validates :city, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :state, presence: true
end
