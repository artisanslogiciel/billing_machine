class AddAttachmentLogoToIdCards < ActiveRecord::Migration
  def self.up
    change_table :id_cards do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :id_cards, :logo
  end
end
