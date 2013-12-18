high = (low) ->
  console.log "executing lower fn ..."
  low()
  
high -> console.log 'this is the lower fn.'