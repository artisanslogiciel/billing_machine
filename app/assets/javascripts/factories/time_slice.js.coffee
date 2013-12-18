app.factory "TimeSlice", ["$resource", ($resource) ->
  $resource("/api/v1/time_slices/:id", {id: "@id"}, {update: {method: "PUT"}})
]