class AddRegistrationCityToIdCard < ActiveRecord::Migration
  def change
    add_column :id_cards, :registration_city, :string
  end
end
