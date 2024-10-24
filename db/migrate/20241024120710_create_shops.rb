class CreateShops < ActiveRecord::Migration[7.2]
  def change
    create_table :shops do |t|
      t.string :shop_name
      t.string :area
      t.decimal :price
      t.string :shop_image

      t.timestamps
    end
  end
end
