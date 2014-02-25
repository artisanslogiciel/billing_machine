@app.factory "PaymentTerm", ["$resource", ($resource) ->
  $resource("/api/v1/payment_terms/:id", {id: "@id"})
]