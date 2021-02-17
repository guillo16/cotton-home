class Shipping < ApplicationRecord
  before_save :format_name

  belongs_to :order
  belongs_to :user

  validates :address, presence: true
  validates :amount, presence: true
  validates :city, presence: true
  validates :first_name, presence: true, length: { in: 2..20, allow_blank: true }
  validates :last_name, presence: true, length: { in: 2..20, allow_blank: true }
  validates :state, presence: true

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}".strip
  end

  private

  def format_name
    self.first_name = first_name.split(" ").map(&:capitalize).join(" ")
    self.last_name = last_name.split(" ").map(&:capitalize).join(" ")
  end
end
