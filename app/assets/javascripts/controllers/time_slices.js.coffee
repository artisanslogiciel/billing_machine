app.controller "TimeSliceCtrl", ["$scope", "TimeSlice", "Project", "Activity", ($scope, TimeSlice, Project, Activity) ->
  $scope.timeslices = TimeSlice.query()
  $scope.projects = Project.query()
  $scope.activities = Activity.query()

  $scope.addTimeSlice = ->
    timeslice = TimeSlice.save($scope.newTimeSlice)
    $scope.timeslices.push(timeslice)
    $scope.newTimeSlice = {}

  $scope.update = (timeslice) ->
    timeslice.$update()
]