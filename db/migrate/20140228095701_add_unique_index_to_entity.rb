class AddUniqueIndexToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :unique_index, :integer, default: 0
    add_column :invoices, :unique_index, :integer
    add_index :entities, [:id, :unique_index], :unique => true
  end
end
