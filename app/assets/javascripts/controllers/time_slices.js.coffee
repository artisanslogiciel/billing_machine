@app.controller "TimeSliceCtrl", ["$scope", "TimeSlice", "Project", "Activity", ($scope, TimeSlice, Project, Activity) ->
  $scope.projects = Project.query()
  $scope.activities = Activity.query()
  $scope.getIsoDate = ->
    new Date().toISOString().split('T')[0]

  $scope.newTimeSlice = {day: $scope.getIsoDate()}
  $scope.timeslices = TimeSlice.query (time_slices) ->
    $scope.totalItems = time_slices.length

  $scope.currentPage = 1;
  $scope.pageSize = 10;
  $scope.totalItems = 0;

  $scope.numPages = -> 
    $scope.totalItems / $scope.pageSize

  $scope.addTimeSlice = ->
    timeslice = TimeSlice.save($scope.newTimeSlice)
    $scope.timeslices.splice(0,0,timeslice)
    $scope.newTimeSlice = {day: $scope.getIsoDate()}

  $scope.update = (timeslice) ->
    timeslice.$update()

  # $scope.projectName = (project_id) ->
  #   project = _.findWhere $scope.projects, {id: project_id}
  #   if project
  #     project.name
  #   else
  #     ''
  # $scope.activityLabel = (activity_id) ->
  #   activity = _.findWhere $scope.activities, {id: activity_id}
  #   if activity
  #     activity.label
  #   else
  #     ''
]
