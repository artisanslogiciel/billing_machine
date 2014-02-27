@app.controller 'InvoicesCtrl', ["$scope", "Customer", "Invoice", ($scope, Customer, Invoice) ->
  $scope.customers = Customer.query()
  $scope.invoices = Invoice.query()

  $scope.customerName = (id) ->
    customer = _.findWhere $scope.customers, {id: id}
    if customer
      customer.name
    else
      ''

]

@app.controller 'InvoiceCtrl', ["$scope", "Customer", "PaymentTerm", "Invoice", ($scope, Customer, PaymentTerm, Invoice) ->
  $scope.payment_terms = PaymentTerm.query()
  $scope.customers = Customer.query()
  $scope.invoice = { label: '', lines_attributes: [] }
  $scope.new_line = {} 

  $scope.customer = ->
    _.findWhere $scope.customers, {id: $scope.invoice.customer_id} if $scope.invoice?

  $scope.new_line_total = ->
    amount = parseFloat($scope.new_line.quantity) * parseFloat($scope.new_line.unit_price)
    $scope.new_line.total = amount
 
  $scope.sum = ->
    console.log $scope.invoice.lines_attributes
    sum = (arr) -> _.reduce arr, ((memo, num) -> memo + num), 0
    $scope.invoice.total_duty = sum _.pluck($scope.invoice.lines_attributes, 'total')
    $scope.invoice.vat = $scope.invoice.total_duty * 0.2
    $scope.invoice.total_all_taxes = $scope.invoice.total_duty * 1.2

  $scope.add_new_line = ->
    $scope.new_line.quantity = parseFloat($scope.new_line.quantity)
    $scope.new_line.unit_price = parseFloat($scope.new_line.unit_price)
    $scope.invoice.lines_attributes.push $scope.new_line
    $scope.new_line = {}
    $scope.sum()
  
  $scope.submit = ->
    delete $scope.invoice.errors
    if $scope.invoice.id?
      $scope.invoice.$update(
        (response) ->
          console.log 'Invoice updated'
        (error) ->
          invoice.errors = error.data
          console.log error.data
      )
    else
      Invoice.save(
        $scope.invoice
        (response) ->
          $scope.invoice = response
        (error) ->
          console.log error
          $scope.invoice.errors = error.data
      )
    $scope.sum()

]
