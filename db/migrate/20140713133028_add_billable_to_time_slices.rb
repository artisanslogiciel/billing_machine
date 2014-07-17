class AddBillableToTimeSlices < ActiveRecord::Migration
  def change
    add_column :time_slices, :billable, :boolean, default: false
  end
end
