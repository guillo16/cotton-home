class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :payment_status
      t.string :payment_status_detail
      t.string :processing_mode
      t.string :merchant_order_id
      t.string :back_url
      t.string :merchant_account_id
      t.string :authenticity_token
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
