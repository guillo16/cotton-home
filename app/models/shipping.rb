class Shipping < ApplicationRecord
  before_save :format_name

  belongs_to :order
  belongs_to :user

  validates :address, presence: true
  validates :area_code, length: { in: 2..5 }, numericality: true, allow_blank: true
  validates :area_code, presence: true
  validates :building, length: { in: 1..8, allow_blank: true }
  validates :city, presence: true
  validates :dni, presence: true, length: { in: 7..8, allow_blank: true }
  validates :floor, length: { in: 1..2 }, numericality: true, allow_blank: true
  validates :first_name, presence: true, length: { in: 2..20, allow_blank: true }
  validates :last_name, presence: true, length: { in: 2..20, allow_blank: true }
  validates :number, presence: true, numericality: true, allow_blank: true
  validates :phone, length: { in: 5..9 }, numericality: true, allow_blank: true
  validates :phone, presence: true
  validates :postal_code, presence: true, length: { in: 4..8, allow_blank: true }
  validates :shipping_method, presence: true
  validates :state, presence: true

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}".strip
  end

  def full_number
    "#{area_code}-#{phone}"
  end

  private

  def format_name
    self.first_name = first_name.split(" ").map(&:capitalize).join(" ")
    self.last_name = last_name.split(" ").map(&:capitalize).join(" ")
  end

  def sanitize_area_code
    self.area_code = area_code&.delete("^0-9")
  end

  def sanitize_phone
    self.phone = phone&.delete("^0-9")
  end
end
