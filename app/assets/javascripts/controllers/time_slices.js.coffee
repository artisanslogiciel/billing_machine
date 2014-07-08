@app.controller "TimeSliceCtrl", ["$scope", "TimeSlice", "Project", "Activity", ($scope, TimeSlice, Project, Activity) ->
  $scope.timeslices = TimeSlice.query()
  $scope.projects = Project.query()
  $scope.activities = Activity.query()

  $scope.addTimeSlice = ->
    timeslice = TimeSlice.save(
      $scope.newTimeSlice
      (response) ->
        console.log response
        console.log "SUCCESS"
      (error) ->
        console.log error
        console.log "FAIL"
      )
    $scope.timeslices.splice(0,0,timeslice)
    $scope.newTimeSlice = {}

  $scope.update = (timeslice) ->
    timeslice.$update()

  $scope.projectName = (project_id) ->
    project = _.findWhere $scope.projects, {id: project_id}
    if project
      project.name
    else
      ''
  $scope.activityLabel = (activity_id) ->
    activity = _.findWhere $scope.activities, {id: activity_id}
    if activity
      activity.label
    else
      ''
]
