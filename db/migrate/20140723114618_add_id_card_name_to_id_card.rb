class AddIdCardNameToIdCard < ActiveRecord::Migration
  def change
    add_column :id_cards, :id_card_name, :string
  end
end
