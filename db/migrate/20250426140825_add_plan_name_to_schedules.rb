class AddPlanNameToSchedules < ActiveRecord::Migration[7.2]
  def change
    add_column :schedules, :plan_name, :string
  end
end
