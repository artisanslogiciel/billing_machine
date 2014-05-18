@app.filter "euros", ->
  (input) ->
    input = parseFloat(input)
    if isNaN(input)
      return '0.00€'
    else
      input.toFixed(2) + '€'
