class Dimension < ApplicationRecord
  belongs_to :article

  validates :size, presence: true
  validates :price, presence: true
  validates :description, presence: true
end
