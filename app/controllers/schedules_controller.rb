class SchedulesController < ApplicationController
  before_action :require_login
  before_action :set_room
  before_action :set_schedule, only: [ :edit, :update, :destroy ]
  before_action :set_selected_date, only: [ :index, :new ]

  # 日付選択画面
  def select_date
    @available_dates = (@room.date_start..@room.date_end).to_a
  end

  # 日付選択後にスケジュール表示
  def choose_date
    if params[:date].present?
      @selected_date = Date.parse(params[:date])
      redirect_to room_schedules_path(@room, date: @selected_date) and return
    else
      flash[:alert] = "日付を選択してください"
      redirect_to select_date_room_schedules_path(@room)
    end
  end

  # スケジュール一覧画面
  def index
    if @selected_date
      @schedules = @room.schedules.where(selected_date: @selected_date).order(:time_start)
    else
      flash[:alert] = "日付が選択されていません"
      redirect_to select_date_room_schedules_path(@room)
    end
  end

  # スケジュール新規作成画面
  def new
    @schedule = @room.schedules.build(selected_date: @selected_date)
  end

  def create
    @schedule = @room.schedules.build(schedule_params)

    # selected_dateを確実に設定
    @schedule.selected_date = @selected_date || (params[:schedule][:selected_date].present? ? Date.parse(params[:schedule][:selected_date]) : nil)

    Rails.logger.debug "Schedule Params on Create: #{schedule_params.inspect}"
    Rails.logger.debug "Selected Date on Create: #{@schedule.selected_date}"

    if @schedule.save
      redirect_to room_schedules_path(@room, date: @schedule.selected_date), notice: "スケジュールが追加されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to room_schedules_path(@room, date: @schedule.selected_date), notice: "スケジュールが更新されました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy
    redirect_to room_schedules_path(@room, date: @schedule.selected_date), notice: "スケジュールが削除されました"
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_schedule
    @schedule = @room.schedules.find(params[:id])
  end

  # 選択された日付を設定するメソッド
  def set_selected_date
    if params[:date].present?
      @selected_date = Date.parse(params[:date])
    else
      flash[:alert] = "日付が選択されていません"
      redirect_to select_date_room_schedules_path(@room)
    end
  end

  def schedule_params
    params.require(:schedule).permit(:time_start, :time_end, :content, :schedule_category, :fix, :date_start, :date_end, :selected_date)
  end
end
