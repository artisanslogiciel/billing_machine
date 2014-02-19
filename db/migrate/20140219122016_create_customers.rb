class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.integer :zip
      t.string :city

      t.timestamps
    end
  end
end
