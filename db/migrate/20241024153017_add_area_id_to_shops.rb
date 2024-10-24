class AddAreaIdToShops < ActiveRecord::Migration[7.2]
  def change
    add_column :shops, :area_id, :bigint
    add_index :shops, :area_id
    add_foreign_key :shops, :areas
  end
end
