class AddContactEmailToIdCard < ActiveRecord::Migration
  def change
    add_column :id_cards, :contact_email, :string
  end
end
