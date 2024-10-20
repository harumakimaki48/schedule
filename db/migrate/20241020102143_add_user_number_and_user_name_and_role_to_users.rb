class AddUserNumberAndUserNameAndRoleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :user_number, :string, null: false
    add_column :users, :user_name, :string, null: false
    add_column :users, :role, :integer, default: 0, null: false
    add_index :users, :user_number, unique: true
  end
end
