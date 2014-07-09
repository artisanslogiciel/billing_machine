class ChangeVatRateTypeInInvoice < ActiveRecord::Migration
  def change
    change_column :invoices, :vat_rate, :decimal
  end
end
