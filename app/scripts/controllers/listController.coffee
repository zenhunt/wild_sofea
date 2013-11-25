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
    scope.delete = addresses.delete
    scope.selectAll = addresses.selectAll
    scope.allSelected = addresses.allSelected
    scope.totalCount = -> addresses.all.length
    scope.toggleAdd = ->
      scope.adding = !scope.adding
      scope.toAdd = {} if scope.adding
    scope.add = ->
      scope.toAdd.id = addresses.all.length
      addresses.all.push scope.toAdd
      addresses.filter()
      scope.toAdd = {}
  ]