angular.module('addressbook')
  .controller 'filterController', ['countries', 'groups', 'addresses', '$scope', (countries, groups, addresses, scope) ->
    filter =
      query: ''
      country: countries.all[0]
      group: groups.all[0]

    scope.filter = filter
    scope.countries = countries.all
    scope.groups = groups.all
    scope.runFilter = -> addresses.filter
      query: filter.query
      country: if filter.country == countries.all[0] then '' else filter.country
      group: if filter.group == groups.all[0] then '' else filter.group
  ]