class AddSelectedDateToSchedules < ActiveRecord::Migration[7.2]
  def change
    add_column :schedules, :selected_date, :date
  end
end
