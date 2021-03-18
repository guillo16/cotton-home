class AddFieldsToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :second_description, :string
  end
end
