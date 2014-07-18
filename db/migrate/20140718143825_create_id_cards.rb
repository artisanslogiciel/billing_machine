class CreateIdCards < ActiveRecord::Migration
  def change
    create_table :id_cards do |t|
      t.string :name
      #image TODO
      t.string :siret
      t.string :legal_form
      t.integer :capital
      t.string :registration_number
      t.string :intracommunity_vat
      t.string :address1
      t.string :address2
      t.string :zip
      t.string :city
      t.string :phone
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_address_1
      t.string :contact_address_2
      t.string :contact_zip
      t.string :contact_city
      t.string :iban
      t.string :bic_swift
      t.string :bank_name
      t.string :bank_address
      t.string :ape_naf
      t.string :custom_info_1
      t.string :custom_info_2
      t.string :custom_info_3
      t.timestamps 
    end
  end
end
