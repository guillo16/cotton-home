class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_car(product, variant)
    current_item = line_items.find_by(product_id: product.id, variant_id: variant.id)

    if current_item
      current_item.increment(:quantity)
    else
      current_item = line_items.build(product_id: product.id, variant_id: variant.id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
