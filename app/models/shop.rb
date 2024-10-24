class Shop < ApplicationRecord
    belongs_to :area
    has_one_attached :shop_image
end
