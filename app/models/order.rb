class Order < ApplicationRecord
  extend FriendlyId
  friendly_id :checkout_session_id, use: :slugged

  belongs_to :user
  belongs_to :cart
  has_one :shipping, dependent: :destroy

  monetize :amount_cents
  monetize :total_cents
end
