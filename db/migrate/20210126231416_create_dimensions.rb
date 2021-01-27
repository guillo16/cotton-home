class CreateDimensions < ActiveRecord::Migration[6.0]
  def change
    create_table :dimensions do |t|
      t.string :size
      t.integer :price
      t.string :description
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
