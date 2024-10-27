class Shop < ApplicationRecord
    belongs_to :area
    has_one_attached :shop_image
    has_many :foods_shops
    has_many :foods, through: :foods_shops

    validates :shop_name, presence: true
end
