@app.factory "Invoice", ["$resource", ($resource) ->
  $resource("/api/v1/invoices/:id", {id: "@id"}, {update: {method: "PUT"}})
]