class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :sub_category
  has_many :variants, dependent: :destroy

  validates :name, presence: true
  validates :photo, presence: true

  private

  def should_generate_new_friendly_id?
    slug.blank? || self.name_changed?
  end
end
