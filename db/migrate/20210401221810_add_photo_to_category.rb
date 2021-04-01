class AddPhotoToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :photo_card, :string
  end
end
