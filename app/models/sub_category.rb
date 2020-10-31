class SubCategory < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :category
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
