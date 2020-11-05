class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :sub_category
  has_many :line_items, dependent: :destroy
  has_many :variants, dependent: :destroy
  has_many_attached :photos

  validates :name, presence: true
  validate :photo_should_be_present

  private

  def photo_should_be_present
    return if self.photos.attached?

    errors.add(:photos, "Tiene que estar presente")
  end

  def should_generate_new_friendly_id?
    slug.blank? || self.name_changed?
  end
end
