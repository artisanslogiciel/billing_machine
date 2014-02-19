class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.date :date
      t.integer :customer_id
      t.integer :payment_term_id
      t.string :label
      t.decimal :total_duty
      t.decimal :vat
      t.decimal :total_all_taxes
      t.decimal :advance
      t.decimal :balance
      t.integer :entity_id

      t.timestamps
    end
    add_index :invoices, :customer_id
    add_index :invoices, :entity_id
  end
end
