class Article < ApplicationRecord
  belongs_to :division

  validates :name, presence: true
  validates :photo, presence: true
end
