angular.module('addressbook')
  .controller 'listController', ['addresses', '$scope', (addresses, scope) ->
    scope.getAddresses = -> addresses.filtered
    scope.toggleDetails = (->
      current = null
      (addr) ->
        if  current && !angular.equals(current, addr) then delete current.details
        current = addr
        addr.details = !addr.details
    )()
    scope.delete = (position) ->
      positions = if angular.isArray(position) then position else [position]
      positions.forEach (id)->
        idx = 0
        while idx < addresses.all.length
          addresses.filtered.splice idx, 1 if addresses.filtered[idx] && addresses.filtered[idx].id == id
          return addresses.all.splice idx, 1 if addresses.all[idx].id == id
          idx++
  ]