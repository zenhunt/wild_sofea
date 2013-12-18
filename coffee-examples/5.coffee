high = (low) ->
  console.log "executing lower order fn ..."
  if low? then low() else console.log 'no lower order fn to execute'
  
high()
high -> console.log 'this is the lower fn.'