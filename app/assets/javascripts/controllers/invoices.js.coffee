@app.controller 'InvoicesCtrl', ["$scope", ($scope) ->
]

@app.controller 'InvoiceCtrl', ["$scope", "Customer", "PaymentTerm", ($scope, Customer, PaymentTerm) ->
  $scope.payment_terms = PaymentTerm.query()
  $scope.customers = Customer.query()
  $scope.new_line = {} 
  $scope.customer = ->
    _.findWhere $scope.customers, {id: $scope.invoice.customer_id} if $scope.invoice?
  $scope.new_line_total = ->
    amount = parseFloat($scope.new_line.quantity) * parseFloat($scope.new_line.unit_price)
    if isNaN(amount)
      return '0.00€'
    else  
      amount.toFixed(2)+ '€'

  $scope.add_new_line = ->
    $scope.new_line = {}
  $scope.invoice_total_duty = ->
    "200.00€"
  $scope.invoice_vat = ->
    "40.00€"
  $scope.invoice_total_taxes = ->
    "240.00€"
  
]
