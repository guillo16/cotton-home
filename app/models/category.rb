class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :sub_categories

  validates :name, presence: true, uniqueness: true
  validates :photo, presence: true
end
