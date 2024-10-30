class Payment < ApplicationRecord
  belongs_to :room
  belongs_to :user    # 支払元ユーザー
  belongs_to :recipient, class_name: "User", optional: true  # 支払先ユーザー
  belongs_to :schedule, optional: true
  has_one_attached :receipt_image

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :content, presence: true
end
