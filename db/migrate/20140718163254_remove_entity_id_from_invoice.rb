class RemoveEntityIdFromInvoice < ActiveRecord::Migration
  def change
    remove_column :invoices, :entity_id, :integer
  end
end
