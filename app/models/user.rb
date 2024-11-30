class User < ApplicationRecord
  authenticates_with_sorcery!

  # 中間テーブルとの関係性
  has_many :users_rooms, dependent: :destroy
  has_many :rooms, through: :users_rooms
  has_many :outfits, dependent: :destroy

  has_many :payments  # 支払元としての支払い
  has_many :received_payments, class_name: "Payment", foreign_key: "recipient_id"  # 支払先としての支払い

  # バリデーションの追加
  validates :user_number, presence: true, uniqueness: true
  validates :user_name, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:password] }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password] }

  # Enumでのrole管理
  enum :role, [ :user, :admin ]

  # LINE認証ユーザーのスコープ
  validates :uid, uniqueness: { scope: :provider }, allow_nil: true
  validates :provider, presence: true, if: -> { uid.present? }
end
