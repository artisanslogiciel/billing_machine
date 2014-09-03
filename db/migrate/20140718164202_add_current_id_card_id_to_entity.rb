class AddCurrentIdCardIdToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :current_id_card_id, :integer
  end
end
