@app.controller "TimeSliceCtrl", ["$scope", "TimeSlice", "Project", "Activity", ($scope, TimeSlice, Project, Activity) ->
  $scope.projects = Project.query()
  $scope.activities = Activity.query()
  $scope.info = document.getElementById('info-message')
  $scope.timeslices = TimeSlice.query (time_slices) ->
    $scope.totalItems = time_slices.length

  $scope.currentPage = 1;
  $scope.pageSize = 10;
  $scope.totalItems = 0;

  $scope.numPages = ->
    $scope.totalItems / $scope.pageSize

  $scope.addTimeSlice = ->
    timeslice = TimeSlice.save(
      $scope.newTimeSlice

      (response) ->
        $scope.info.classList.remove('alert-danger')
        $scope.timeslices.splice(0,0,timeslice)
        $scope.info.classList.add('alert-success')
        $scope.info.innerHTML = 'Time slice successfully added'
        $scope.info.style.visibility = 'visible'
        clearTimeout $scope.timeout
        $scope.timer()

      (error) ->
        $scope.error_pop (error)
      )

    $scope.newTimeSlice = {}


  $scope.buildMessageFromError = (error) ->
    if "day" of error.data
      "Please fill a valid date"
    else if "duration" of error.data
      "Duration " + error.data.duration[0]
    else if "TimeSlice" of error.data
      "Time Slice " + error.data.TimeSlice[0]
    else
      "An unknow error occured"

  $scope.vanishMessage = ->
    $scope.info.style.visibility = 'hidden'

  $scope.error_pop = (error) ->
    $scope.info.classList.remove('alert-succes')
    $scope.info.classList.add('alert-danger')
    $scope.info.innerHTML = $scope.buildMessageFromError(error)
    $scope.info.style.visibility= 'visible'
    clearTimeout $scope.timeout
    $scope.timer()

  $scope.update = (timeslice) ->
    timeslice.$update()


  $scope.timer = ->
    $scope.timeout = setTimeout (->
          $scope.vanishMessage()
        ), 10000


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