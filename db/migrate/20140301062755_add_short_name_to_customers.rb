class AddShortNameToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :short_name, :string
  end
end
