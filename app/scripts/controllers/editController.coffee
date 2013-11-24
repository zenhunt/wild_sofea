angular.module('addressbook')
  .controller 'editController', ['countries', 'groups', '$scope', (countries, groups, scope) ->
    scope.countries = countries.selectable
    scope.groups = groups.selectable
    scope.addr
    createClone = -> scope.addressClone = angular.copy scope.addr
    createClone()
    scope.save = ->
      angular.extend scope.addr, scope.addressClone
      scope.editing = false
    scope.edit = ->
      createClone()
      scope.editing = true
      console.log scope.addressClone.edit
  ]