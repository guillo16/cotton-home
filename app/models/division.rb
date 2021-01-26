class Division < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :articles

  validates :name, presence: true
end
