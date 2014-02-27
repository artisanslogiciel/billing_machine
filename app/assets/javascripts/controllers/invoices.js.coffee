@app.controller 'InvoicesCtrl', ["$scope", ($scope) ->
]

@app.controller 'InvoiceCtrl', ["$scope", "Customer", "PaymentTerm", ($scope, Customer, PaymentTerm) ->
  $scope.payment_terms = PaymentTerm.query()
  $scope.customers = Customer.query()
]
