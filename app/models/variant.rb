class Variant < ApplicationRecord
  belongs_to :product

  monetize :price_cents

  validates :size, presence: true, uniqueness: true
  validates :stock, presence: true
  validates :price, presence: true
end
