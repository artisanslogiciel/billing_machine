json.(time_slice, :id, :duration, :comment, :activity_id, :project_id, :day, :billable)

if time_slice.activity
  json.activity do
    json.(time_slice.activity, :id, :label)
  end
end

if time_slice.project
  json.project do
    json.(time_slice.project, :id, :name)
  end
end