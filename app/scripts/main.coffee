angular.module 'addressbook', []

angular.module 'app', ['ngRoute', 'addressbook'],
  ['$routeProvider', '$locationProvider', ($routeProvider) ->
    $routeProvider
    .when '/addresses',
      templateUrl: 'views/addresses.html'
    .when '/credits',
      templateUrl: 'views/credits.html'
    .otherwise
      redirectTo: '/addresses'
  ]