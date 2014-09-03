class RenameContactNameToContactFullNameInIdCard < ActiveRecord::Migration
  def change
    rename_column :id_cards, :contact_name, :contact_full_name
  end
end
