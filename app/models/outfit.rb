class Outfit < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one_attached :headband_image
  has_one_attached :clothing_image
  has_one_attached :bag_image
  has_one_attached :shoes_image

  validates :name, presence: true
end
