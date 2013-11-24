angular.module('addressbook')
  .controller 'navController', ['$scope', '$location', (scope, $location) ->
    scope.isActive = (route) ->
      console.log($location.path())
      route == $location.path()
  ]