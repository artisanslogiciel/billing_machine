@app.directive 'bbItemEdit', ->
  return (scope, element) ->
    element.find('.bb-edit').hide()
    element.find('.bb-show a').bind 'click', -> 
      element.find('.bb-show').hide()
      element.find('.bb-edit').show()
    element.find('.bb-edit :submit').bind 'click', -> 
      element.find('.bb-show').show()
      element.find('.bb-edit').hide()
    
    element.find('a.bb-show').bind 'click', -> 
      element.find('.bb-show').hide()
      element.find('.bb-edit').show()
    element.find('a.bb-edit').bind 'click', -> 
      element.find('.bb-show').show()
      element.find('.bb-edit').hide()
