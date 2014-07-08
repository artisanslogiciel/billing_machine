@app.controller "TimeSliceCtrl", ["$scope", "TimeSlice", "Project", "Activity", ($scope, TimeSlice, Project, Activity) ->
  $scope.timeslices = TimeSlice.query()
  $scope.projects = Project.query()
  $scope.activities = Activity.query()
  $scope.success = document.getElementById('success-message')
  $scope.error = document.getElementById('error-message')
  $scope.addTimeSlice = ->
    timeslice = TimeSlice.save(
      $scope.newTimeSlice

      (response) ->
        $scope.success.style.display = "block"
        $scope.success.innerHTML = 'Time slice successfully added'
        setTimeout (->
          $scope.vanishMessage($scope.success)
        ), 2000
        setTimeout (->
          $scope.removeMessage($scope.success)
        ), 5000

      (error) ->
        $scope.error.style.display = "block"
        $scope.error.innerHTML = error.data.error
        setTimeout (->
          $scope.vanishMessage($scope.error)
        ), 2000
        setTimeout (->
          $scope.removeMessage($scope.error)
        ), 5000
      )
    $scope.timeslices.splice(0,0,timeslice)
    $scope.newTimeSlice = {}

  $scope.vanishMessage = (div) ->
    div.classList.add('vanish')

  $scope.removeMessage = (div) ->
    div.style.display = "none"
    div.classList.remove('vanish')

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
