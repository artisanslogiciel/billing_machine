class ChangeLabelTypeInInvoiceLine < ActiveRecord::Migration
  def change
    change_column :invoice_lines, :label, :text, :limit => nil
  end
end
