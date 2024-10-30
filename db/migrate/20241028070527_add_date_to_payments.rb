class AddDateToPayments < ActiveRecord::Migration[7.2]
  def change
    add_column :payments, :date, :date
  end
end
