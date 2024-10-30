class AddPaymentDateToPayments < ActiveRecord::Migration[7.2]
  def change
    add_column :payments, :payment_date, :string
  end
end
