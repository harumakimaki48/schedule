class CreateOutfits < ActiveRecord::Migration[7.2]
  def change
    create_table :outfits do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
