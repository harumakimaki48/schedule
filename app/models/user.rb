class User < ApplicationRecord
  authenticates_with_sorcery!

  # バリデーションの追加
  validates :user_number, presence: true, uniqueness: true
  validates :user_name, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:password] }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password] }

  # Enumでのrole管理
  enum role: { user: 0, admin: 1 }
end
