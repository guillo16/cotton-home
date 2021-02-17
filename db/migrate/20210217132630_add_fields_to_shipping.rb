class AddFieldsToShipping < ActiveRecord::Migration[6.0]
  def change
    add_column :shippings, :dni, :string
    add_column :shippings, :area_code, :string
    add_column :shippings, :phone, :string
    add_column :shippings, :number, :string
    add_column :shippings, :building, :string
    add_column :shippings, :floor, :string
    add_column :shippings, :postal_code, :string
  end
end
