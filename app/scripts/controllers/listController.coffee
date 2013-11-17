angular.module('addressbook')
  .controller 'listController', ['addresses', '$scope', (addresses, scope) ->
    scope.addresses = addresses.filtered
    scope.toggleDetails = (->
      current = null
      (addr) ->
        if  current && !angular.equals(current, addr) then delete current.details
        current = addr
        addr.details = !addr.details
    )()
  ]