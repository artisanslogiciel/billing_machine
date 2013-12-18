app.directive 'bbNameEdit', ->
  return (scope, element) ->
    element.find('.edit').hide()
    element.find('.show a').bind 'click', -> 
      element.find('.show').hide()
      element.find('.edit').show()
    element.find('.edit :submit').bind 'click', -> 
      element.find('.show').show()
      element.find('.edit').hide()
