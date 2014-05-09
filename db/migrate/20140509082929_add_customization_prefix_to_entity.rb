class AddCustomizationPrefixToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :customization_prefix, :string
  end
end
