@app.controller "TimeSliceCtrl", ["$scope", "TimeSlice", "Project", "Activity", ($scope, TimeSlice, Project, Activity) ->
  $scope.timeslices = TimeSlice.query()
  $scope.projects = Project.query()
  $scope.activities = Activity.query()
  $scope.info = document.getElementById('info-message')
  $scope.addTimeSlice = ->
    timeslice = TimeSlice.save(
      $scope.newTimeSlice

      (response) ->
        $scope.timeslices.splice(0,0,timeslice)
        $scope.info.classList.add('alert-success')
        $scope.info.innerHTML = 'Time slice successfully added'
        $scope.info.style.visibility = 'visible'
        $scope.info.classList.add('vanish')
        setTimeout (->
          $scope.vanishMessage('alert-success')
        ), 10000

      (error) ->
        $scope.error_pop (error)
      )

    $scope.newTimeSlice = {}


  $scope.buildMessageFromError = (error) ->
    if "day" of error.data
      "Please fill a valid date"
    else "Duration " + error.data.duration if "duration" of error.data


  $scope.vanishMessage = (alert_class) ->
    $scope.info.style.visibility = 'hidden'
    $scope.info.classList.remove('vanish')
    $scope.info.classList.remove(alert_class)


  $scope.error_pop = (error) ->
    $scope.info.classList.add('alert-danger')
    $scope.info.innerHTML = $scope.buildMessageFromError(error)
    $scope.info.style.visibility= 'visible'
    $scope.info.classList.add('vanish')
    setTimeout (->
      $scope.vanishMessage('alert-danger')
    ), 10000

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
