class AddDefaultValueToAdministratorInUsers < ActiveRecord::Migration
    def up
      change_column :users, :administrator, :boolean, default: false
    end

    def down
      change_column :users, :administrator, :boolean, default: nil
    end
end
