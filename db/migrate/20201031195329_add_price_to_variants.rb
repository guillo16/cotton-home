class AddPriceToVariants < ActiveRecord::Migration[6.0]
  def change
    add_monetize :variants, :price, currency: { present: false }
  end
end
