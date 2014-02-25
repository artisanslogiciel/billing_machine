class AddEntityIdToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :entity_id, :integer
    add_index :customers, :entity_id
  end
end
