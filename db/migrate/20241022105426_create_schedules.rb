class CreateSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :schedules do |t|
      t.time :time
      t.string :schedule_category
      t.boolean :fix, default: false
      t.date :date_start
      t.date :date_end
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
