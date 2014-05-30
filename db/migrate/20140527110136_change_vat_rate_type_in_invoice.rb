class ChangeVatRateTypeInInvoice < ActiveRecord::Migration
  def change
    change_column :invoices, :vat_rate, :number, {scale: 2}
  end
end
