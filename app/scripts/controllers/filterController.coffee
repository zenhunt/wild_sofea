angular.module('addressbook')
  .controller 'filterController', ['countries', 'groups', 'addresses', '$scope', (countries, groups, addresses, scope) ->
    filter =
      query: ''
      country: countries.all[0]
      group: groups.all[0]
      fields: ['forename', 'lastname', 'email', 'phone', 'street', 'zipcode', 'city']

    scope.filter = filter
    scope.countries = countries.all
    scope.groups = groups.all
  ]