class SorceryCore < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end
  end
end
