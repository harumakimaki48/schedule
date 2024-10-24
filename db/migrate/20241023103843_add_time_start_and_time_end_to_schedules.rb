class AddTimeStartAndTimeEndToSchedules < ActiveRecord::Migration[7.2]
  def change
    add_column :schedules, :time_start, :time
    add_column :schedules, :time_end, :time
  end
end
