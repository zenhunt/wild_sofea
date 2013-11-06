angular.module('addressbook')
  .controller 'filterController', ['countries', 'groups', '$scope', (countries, groups, scope) ->
    scope.countries = countries
    scope.groups = groups
    scope.filter =
      firstname: 'Heinz'
      country: 'DEU'
      group: 1
  ]