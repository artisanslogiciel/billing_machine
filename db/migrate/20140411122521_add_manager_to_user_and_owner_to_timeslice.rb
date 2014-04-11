class AddManagerToUserAndOwnerToTimeslice < ActiveRecord::Migration
  def change
    add_column :users, :manager_id, :integer
    add_column :time_slices, :user_id, :integer
    add_index :time_slices, :user_id
  end
end
