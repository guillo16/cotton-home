class AddTotalToOrder < ActiveRecord::Migration[6.0]
  def change
    add_monetize :orders, :total
  end
end
