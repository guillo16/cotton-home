class Division < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :articles, dependent: :destroy

  validates :name, presence: true
end
