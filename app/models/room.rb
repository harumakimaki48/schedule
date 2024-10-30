class Room < ApplicationRecord
  belongs_to :user
  has_many :users_rooms
  has_many :users, through: :users_rooms
  has_many :schedules, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :payments, dependent: :destroy

  has_secure_password

  validates :room_number, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :date_start, :date_end, presence: true
end
