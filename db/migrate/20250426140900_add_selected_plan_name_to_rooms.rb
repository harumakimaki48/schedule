class AddSelectedPlanNameToRooms < ActiveRecord::Migration[7.2]
  def change
    add_column :rooms, :selected_plan_name, :string
  end
end
