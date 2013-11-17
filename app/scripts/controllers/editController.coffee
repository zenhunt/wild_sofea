angular.module('addressbook')
  .controller 'editController', ['countries', 'groups', '$scope', (countries, groups, scope) ->
    scope.countries = countries.selectable
    scope.groups = groups.selectable
  ]