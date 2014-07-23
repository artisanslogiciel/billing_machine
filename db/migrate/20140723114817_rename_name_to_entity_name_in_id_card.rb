class RenameNameToEntityNameInIdCard < ActiveRecord::Migration
  def change
    rename_column :id_cards, :name, :entity_name
  end
end
