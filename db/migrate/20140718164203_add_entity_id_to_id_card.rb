class AddEntityIdToIdCard < ActiveRecord::Migration
  def change
    add_reference :id_cards, :entity, index: true
  end
  
  def data
    if ActiveRecord::Base.connection.column_exists?(:invoices, :entity_id)
      Entity.all.each do |entity|
        IdCard.create(entity_id: entity.id)
      end
      Invoice.all.each do |invoice|
        invoice.id_card_id = IdCard.where(entity_id: invoice.entity_id)
      end
    end
  end
end
