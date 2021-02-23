class AddFieldToShipping < ActiveRecord::Migration[6.0]
  def change
    add_column :shippings, :shipping_method, :string
  end
end
