@app.controller 'InvoicesCtrl', ["$scope", "Customer", "Invoice", "$location", ($scope, Customer, Invoice, $location) ->
  $scope.customers = Customer.query()
  $scope.invoices = Invoice.query()

  $scope.navNewInvoice = ->
    $location.url('/invoices/new')

  $scope.navEditInvoice = (invoice)->
    $location.url('/invoices/'+invoice.id)

  $scope.statusPaid = (invoice)->
    invoice.paid = true
    invoice.$update(
      (response) ->
      (error) ->
        invoice.errors = error.data
        console.log "An error occured"
        console.log error.data
    )

  $scope.customerName = (id) ->
    customer = _.findWhere $scope.customers, {id: id}
    if customer
      customer.name
    else
      ''

]

@app.controller 'InvoiceCtrl', ["$scope", "$location", "$routeParams", "Customer", "PaymentTerm", "Invoice", ($scope, $location, $routeParams, Customer, PaymentTerm, Invoice) ->
  # begin of functions definition used by controller
  $scope.set_vat_rate_default_value = ->
    VAT_RATE_DEFAUT_VALUE = 20
    $scope.invoice.vat_rate = VAT_RATE_DEFAUT_VALUE

  $scope.set_invoice = ->
    if $routeParams.id?
      $scope.invoice = Invoice.get({id: parseInt($routeParams.id)})
    else
      $scope.invoice = { label: '', lines_attributes: [] }
  # end of functions definition used by controller

  $scope.payment_terms = PaymentTerm.query()
  $scope.customers = Customer.query()

  $("input#invoice-date").mask("9999-99-99");

  $scope.set_invoice()

  $scope.set_vat_rate_default_value()

  $scope.new_line = {}

  # begin of functions definition used in view
  $scope.customer = ->
    _.findWhere $scope.customers, {id: $scope.invoice.customer_id} if $scope.invoice?

  $scope.navToList = ->
    $location.url('/invoices')

  $scope.line_total = (invoice_line) ->
    amount = parseFloat(invoice_line.quantity) * parseFloat(invoice_line.unit_price)
    if isNaN(amount)
      invoice_line.total = 0
    else
      invoice_line.total = amount
    $scope.sum()
    return invoice_line.total

  $scope.sum = ->
    sum = (arr) -> _.reduce arr, ((memo, num) -> memo + num), 0
    values = _.map($scope.invoice.lines_attributes, (line) ->
      if line._destroy?
        0
      else
        line.total
    )
    $scope.invoice.total_duty = sum values
    return $scope.invoice.total_all_taxes

  $scope.calculate_vat = ->
    $scope.invoice.vat = $scope.invoice.total_duty * ($scope.invoice.vat_rate/100)
    $scope.invoice.total_all_taxes = $scope.invoice.total_duty + $scope.invoice.vat
    return $scope.invoice.vat

  $scope.edit_line = (invoice_line) ->
    invoice_line.quantity = parseFloat(invoice_line.quantity)
    invoice_line.unit_price = parseFloat(invoice_line.unit_price)
    $scope.sum()

  $scope.delete_line = (invoice_line) ->
    invoice_line._destroy = 1
    $scope.sum()

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
        (error) ->
          invoice.errors = error.data
          console.log "An error occured"
          console.log error.data
      )
    else
      Invoice.save(
        $scope.invoice
        (response) ->
          $scope.invoice = response
        (error) ->
          $scope.invoice.errors = error.data
          console.log "An error occured"
          console.log error.data
      )
    $scope.sum()
]
