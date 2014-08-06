@app.controller 'InvoicesCtrl', ["$scope", "Customer", "Invoice", "$location", ($scope, Customer, Invoice, $location) ->
  $scope.customers = Customer.query()
  $scope.invoices = Invoice.query()
  $scope.info = document.getElementById('info-message')

  $scope.navNewInvoice = ->
    $location.url('/invoices/new')
    $scope.resetMessage()

  $scope.navEditInvoice = (invoice)->
    $location.url('/invoices/'+invoice.id)
    $scope.resetMessage()

  $scope.statusPaid = (invoice)->
    invoice.paid = true
    invoice.$update(
      (response) ->
        $scope.popSuccessMessage('invoice successfully set to paid')
      (error) ->
        invoice.errors = error.data
        console.log "An error occured"
        console.log error.data
    )
# begin invoice color
  $scope.colorIfPaidOrLate = (invoice)->
    if invoice.paid
      return "green"
    difference = todayMinusDate(invoice.due_date)
    if payment_very_late(difference)
      return "red"
    else if payment_late(difference)
      return "orange"

  payment_late = (difference)->
    0 < difference < 16

  payment_very_late = (difference)->
    difference > 15

  todayMinusDate = (dateString)->
    date = new Date(dateString)
    today = localeDateTime()
    days = milesecondsToDays(today - date)
    daysTruncated = Math.floor(days)

  localeDateTime = ->
    nowUtc = new Date()
    offset = nowUtc.getTimezoneOffset()
    return new Date(nowUtc.getTime() - offset*60000)

  milesecondsToDays = (miliseconds)->
    MILISECONDS_IN_A_DAY = 86400000
    days = miliseconds / MILISECONDS_IN_A_DAY
# end invoice color
  $scope.customerName = (id) ->
    customer = _.findWhere $scope.customers, {id: id}
    if customer
      customer.name
    else
      ''

  $scope.timer = ->
      $scope.timeout = setTimeout (->
            $scope.vanishMessage()
          ), 10000

    $scope.vanishMessage = ->
      $scope.info.style.visibility = 'hidden'

    $scope.popSuccessMessage = (message) ->
      $scope.info.classList.remove('alert-danger')
      $scope.info.classList.add('alert-success')
      $scope.info.innerHTML = message
      $scope.info.style.visibility = 'visible'
      clearTimeout $scope.timeout
      $scope.timer()

    $scope.resetMessage = ->
      $scope.vanishMessage()
      clearTimeout $scope.timeout
]

@app.controller 'InvoiceCtrl', ["$scope", "$location", "$routeParams", "Customer", "PaymentTerm", "Invoice", ($scope, $location, $routeParams, Customer, PaymentTerm, Invoice) ->
  $scope.info = document.getElementById('info-message')
  # begin of functions definition used by controller
  $scope.set_vat_rate_default_value = ->
    $scope.invoice.vat_rate = VAT_RATE_DEFAULT_VALUE = 20
    $scope.invoice.advance = ADVANCE_DEFAULT_VALUE = 0

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
    $scope.resetMessage()

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

  $scope.calculate_balance = ->
    $scope.invoice.balance = $scope.invoice.total_all_taxes - $scope.invoice.advance

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
          $scope.popSuccessMessage('Invoice successfully updated')
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
          $scope.popSuccessMessage('Invoice successfully saved')
        (error) ->
          $scope.invoice.errors = error.data
          console.log "An error occured"
          console.log error.data
      )
    $scope.sum()

  $scope.timer = ->
    $scope.timeout = setTimeout (->
          $scope.vanishMessage()
        ), 10000

  $scope.vanishMessage = ->
    $scope.info.style.visibility = 'hidden'

  $scope.popSuccessMessage = (message) ->
    $scope.info.classList.remove('alert-danger')
    $scope.info.classList.add('alert-success')
    $scope.info.innerHTML = message
    $scope.info.style.visibility = 'visible'
    clearTimeout $scope.timeout
    $scope.timer()

  $scope.resetMessage = ->
    $scope.vanishMessage()
    clearTimeout $scope.timeout
]