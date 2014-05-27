class AddVatRateToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :vat_rate, :integer
  end
end
