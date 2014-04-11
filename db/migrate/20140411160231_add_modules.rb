class AddModules < ActiveRecord::Migration
  def change
    add_column :entities, :billing_machine, :boolean, default: false
    add_column :entities, :time_machine, :boolean, default: false
    add_column :users, :billing_machine, :boolean, default: false
    add_column :users, :time_machine, :boolean, default: false
  end
end
