class AddNameToSubCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :sub_categories, :name, :string
  end
end
