class AddCommentToTimeSlice < ActiveRecord::Migration
  def change
    add_column :time_slices, :comment, :text
  end
end
