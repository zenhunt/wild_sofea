angular.module('addressbook')
  .controller 'navController', ['$scope', '$location', (scope, $location) ->
    scope.isActive = (route) -> route == $location.path()
  ]