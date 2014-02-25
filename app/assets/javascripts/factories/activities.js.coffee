@app.factory "Activity", ["$resource", ($resource) ->
  $resource("/api/v1/activities/:id", {id: "@id"}, {update: {method: "PUT"}})
]