class AddClarificationToDimension < ActiveRecord::Migration[6.0]
  def change
    add_column :dimensions, :clarification, :string
  end
end
