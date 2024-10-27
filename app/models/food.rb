class Food < ApplicationRecord
  belongs_to :room
  has_many :foods_shops
  has_many :foods_shops, dependent: :destroy
  has_many :shops, through: :foods_shops


  validates :menu_name, presence: true
  validates :price, presence: true
end
