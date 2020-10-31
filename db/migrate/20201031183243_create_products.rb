class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :photo
      t.references :sub_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
