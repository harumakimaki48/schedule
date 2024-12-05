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

  # コールバック: 新規作成時に一意の user_number を生成
  before_validation :set_unique_user_number, on: :create

  # Enum管理
  enum :role, [ :user, :admin ]

  # トークン管理
  def generate_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
    save(validate: false)
  end

  def clear_remember_token
    update(remember_token: nil)
  end

  private

  def set_unique_user_number
    self.user_number ||= generate_unique_user_number
  end

  def generate_unique_user_number
    loop do
      unique_number = "user_#{SecureRandom.hex(5)}"
      break unique_number unless User.exists?(user_number: unique_number)
    end
  end
end
