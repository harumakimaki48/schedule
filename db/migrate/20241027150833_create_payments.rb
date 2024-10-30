class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true
      t.references :recipient, foreign_key: { to_table: :users }  # 支払先
      t.references :schedule, foreign_key: true
      t.string :content
      t.integer :amount
      t.string :status, default: '未精算'

      t.timestamps
    end
  end
end
