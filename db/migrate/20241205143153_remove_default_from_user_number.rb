class RemoveDefaultFromUserNumber < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :user_number, nil
  end
end
