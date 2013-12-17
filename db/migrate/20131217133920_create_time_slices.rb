class CreateTimeSlices < ActiveRecord::Migration
  def change
    create_table :time_slices do |t|
      t.date :day
      t.integer :project_id
      t.decimal :duration
      t.integer :activity_id

      t.timestamps
    end
  end
end
