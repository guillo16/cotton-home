class AddAmountToShipping < ActiveRecord::Migration[6.0]
  def change
    add_column :shippings, :amount, :integer
  end
end
