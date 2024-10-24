class CreateAreas < ActiveRecord::Migration[7.2]
  def change
    create_table :areas do |t|
      t.string :area_name

      t.timestamps
    end
  end
end
