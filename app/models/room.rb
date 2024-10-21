class Room < ApplicationRecord
  belongs_to :user # 部屋の作成者

  has_many :users_rooms
  has_many :users, through: :users_rooms

  has_secure_password  # password_digestを利用してパスワードを暗号化

  validates :room_number, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :date_start, :date_end, presence: true
end
