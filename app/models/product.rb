class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :sub_category

  validates :name, presence: true
  validates :photo, presence: true
end
