angular.module('addressbook')
  .controller 'filterController', ['countries', 'groups', '$scope', (countries, groups, scope) ->
    scope.countries = countries.data
    scope.groups = groups.data
    scope.filter =
      firstname: 'Heinz'
      country: 'DEU'
      group: 1
  ]