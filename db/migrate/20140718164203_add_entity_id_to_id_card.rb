class AddEntityIdToIdCard < ActiveRecord::Migration
  def change
    add_reference :id_cards, :entity, index: true
  end
  
  def data
    if ActiveRecord::Base.connection.column_exists?(:invoices, :entity_id)
      Entity.all.each do |entity|
        IdCard.create(entity_id: entity.id, name: entity.name)
      end
      Invoice.all.each do |invoice|
        id_card = IdCard.where(entity_id: invoice.entity_id).take
        invoice.id_card_id = id_card.id
        invoice.save
      end
    end
  end
end
