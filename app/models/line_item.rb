class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :variant
  validates :quantity, presence: true

  def total_price
    variant.price.to_i * quantity.to_i
  end
end
