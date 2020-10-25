class RemoveTitleFromSubCategories < ActiveRecord::Migration[6.0]
  def change
    remove_column :sub_categories, :title, :string
  end
end
