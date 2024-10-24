class AddParkIdToShops < ActiveRecord::Migration[7.2]
  def change
    add_column :shops, :park_id, :bigint
  end
end
