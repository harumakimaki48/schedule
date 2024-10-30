class Schedule < ApplicationRecord
  belongs_to :room
  has_many :payments, dependent: :destroy

  # Roomのdate_startとdate_endを自動的にセット
  before_save :set_dates_from_room

  # バリデーションは必要に応じて有効にします
  # 　validates :schedule_category, :time_start, :time_end, presence: true

  # 重複チェック機能はコメントアウトしたまま残しておきます
  # validate :check_time_overlap

  private

  # Roomのdate_startとdate_endをスケジュールに設定する
  def set_dates_from_room
    self.date_start = room.date_start
    self.date_end = room.date_end
  end

  # 重複チェック機能（必要に応じて後で有効に）
  # def check_time_overlap
  #   overlapping_schedule = Schedule.where(room_id: room_id, date_start: date_start)
  #                                  .where.not(id: id)
  #                                  .where('(time_start < ? AND time_end > ?)', time_end, time_start)

  #   if overlapping_schedule.exists?
  #     errors.add(:time_start, "時間が他のパレードやショーと重複しています。")
  #   end
  # end
end
