@app.controller 'InvoicesCtrl', ["$scope", ($scope) ->
]

@app.controller 'InvoiceCtrl', ["$scope", "Customer", "PaymentTerm", ($scope, Customer, PaymentTerm) ->
  $scope.payment_terms = PaymentTerm.query()
  $scope.customers = Customer.query()
  $scope.invoice = { lines_attributes: [] }
  $scope.new_line = {} 

  $scope.customer = ->
    _.findWhere $scope.customers, {id: $scope.invoice.customer_id} if $scope.invoice?

  $scope.new_line_total = ->
    amount = parseFloat($scope.new_line.quantity) * parseFloat($scope.new_line.unit_price)
    $scope.new_line.total = amount

  $scope.add_new_line = ->
    $scope.invoice.lines_attributes.push $scope.new_line
    
    $scope.new_line = {}

  $scope.invoice_total_duty = ->
    sum = (arr) -> _.reduce arr, ((memo, num) -> memo + num), 0
    sum _.pluck($scope.invoice.lines_attributes, 'total')
  $scope.invoice_vat = ->
    $scope.invoice_total_duty() * 0.2
  $scope.invoice_total_taxes = ->
    $scope.invoice_total_duty() * 1.2
  
]
