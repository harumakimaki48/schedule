class User < ApplicationRecord
  authenticates_with_sorcery!

  # 関連付け
  has_many :users_rooms, dependent: :destroy
  has_many :rooms, through: :users_rooms
  has_many :outfits, dependent: :destroy
  has_many :payments
  has_many :received_payments, class_name: "Payment", foreign_key: "recipient_id"

  # バリデーション
  validates :user_number, presence: true, uniqueness: true
  validates :user_name, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:password] }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password] }

  # Enum管理
  enum :role, [:user, :admin]

  # トークン管理
  def generate_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
    save(validate: false)
  end

  def clear_remember_token
    update(remember_token: nil)
  end
end
