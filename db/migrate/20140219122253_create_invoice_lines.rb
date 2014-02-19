class CreateInvoiceLines < ActiveRecord::Migration
  def change
    create_table :invoice_lines do |t|
      t.string :label
      t.decimal :quantity
      t.string :unit
      t.decimal :unit_price
      t.decimal :total
      t.integer :invoice_id

      t.timestamps
    end
    add_index :invoice_lines, :invoice_id
  end
end
