class RemoveTimeFromSchedules < ActiveRecord::Migration[7.2]
  def change
    remove_column :schedules, :time, :time
  end
end
