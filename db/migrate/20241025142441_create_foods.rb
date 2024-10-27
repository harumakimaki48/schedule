class CreateFoods < ActiveRecord::Migration[7.2]
  def change
    create_table :foods do |t|
      t.string :menu_name
      t.decimal :price
      t.boolean :favorite
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
