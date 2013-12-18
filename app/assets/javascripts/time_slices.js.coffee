app.factory "TimeSlice", ["$resource", ($resource) ->
  $resource("/api/v1/time_slices/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.controller "TimeSliceCtrl", ["$scope", "TimeSlice", ($scope, TimeSlice) ->
  $scope.timeslices = TimeSlice.query()

  $scope.addTimeSlice = ->
    timeslice = TimeSlice.save($scope.newTimeSlice)
    $scope.timeslices.push(timeslice)
    $scope.newTimeSlice = {}

  $scope.update = (timeslice) ->
    timeslice.$update()
]