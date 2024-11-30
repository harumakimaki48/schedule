class AddDefaultToUserNumber < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :user_number, from: nil, to: "default_number"
  end
end
