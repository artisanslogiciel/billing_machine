@app.controller 'InvoicesCtrl', ["$scope", ($scope) ->
]

@app.controller 'InvoiceCtrl', ["$scope", "PaymentTerm", ($scope, PaymentTerm) ->
  $scope.payment_terms = PaymentTerm.query()
]