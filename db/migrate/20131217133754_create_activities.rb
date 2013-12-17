class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :label

      t.timestamps
    end
  end
end
