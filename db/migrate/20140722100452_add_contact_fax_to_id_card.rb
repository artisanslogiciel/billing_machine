class AddContactFaxToIdCard < ActiveRecord::Migration
  def change
    add_column :id_cards, :contact_fax, :string
  end
end
