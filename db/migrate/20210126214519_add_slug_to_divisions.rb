class AddSlugToDivisions < ActiveRecord::Migration[6.0]
  def change
    add_column :divisions, :slug, :string
    add_index :divisions, :slug, unique: true
  end
end
