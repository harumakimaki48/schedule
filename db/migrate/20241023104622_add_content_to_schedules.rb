class AddContentToSchedules < ActiveRecord::Migration[7.2]
  def change
    add_column :schedules, :content, :string
  end
end