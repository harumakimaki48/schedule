class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.string :room_number, null: false
      t.string :password_digest, null: false
      t.date :date_start
      t.date :date_end
      t.references :user, foreign_key: true  # 部屋の作成者の参照

      t.timestamps
    end

    add_index :rooms, :room_number, unique: true  # 部屋番号にユニーク制約を追加
  end
end
