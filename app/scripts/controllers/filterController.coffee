angular.module('addressbook')
  .controller 'filterController', ['countries', 'groups', 'addresses', '$scope', (countries, groups, addresses, scope) ->
    filter = null
    scope.filterCountries = countries
    scope.editCountries = countries.slice 1
    scope.filterGroups = groups
    scope.editGroups = groups.slice 1
    scope.addresses = angular.copy addresses
    scope.filter = filter =
      query: ''
      country: countries[0]
      group: groups[0]
      fields: ['forename', 'lastname', 'email', 'phone', 'street', 'zipcode', 'city']
    scope.toggleDetails = (->
      current = null
      (addr) ->
        if  current && !angular.equals(current, addr) then delete current.details
        current = addr
        addr.details = !addr.details
    )()

#    ['query', 'country', 'group'].forEach (filterAttr) ->
#      scope.$watch filterAttr, ->
#        scope.addresses = addresses.filter (addr) ->
#          (filter.country == countries[0] || addr.country == filter.country) && filter.fields.some (field) ->
#            addr[field].indexOf filter.query >= 0
#        scope.$apply()
  ]