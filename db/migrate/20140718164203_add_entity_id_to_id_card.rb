class AddEntityIdToIdCard < ActiveRecord::Migration
  def change
    add_reference :id_cards, :entity, index: true
  end
end
