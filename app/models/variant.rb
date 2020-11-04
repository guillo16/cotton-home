class Variant < ApplicationRecord
  belongs_to :product
  has_many :line_items, dependent: :destroy

  monetize :price_cents

  validates :size, presence: true
  validates :stock, presence: true
  validates :price, presence: true
end
