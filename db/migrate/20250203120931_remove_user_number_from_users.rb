class RemoveUserNumberFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :user_number, :string
  end
end
