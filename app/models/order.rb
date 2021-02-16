class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  has_one :shipping, dependent: :destroy

  monetize :amount_cents
  monetize :total_cents
end
