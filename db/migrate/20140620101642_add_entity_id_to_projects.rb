class AddEntityIdToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :entity, index: true
  end
end
