@app.factory "Customer", ["$resource", ($resource) ->
  $resource("/api/v1/customers/:id", {id: "@id"})
]
