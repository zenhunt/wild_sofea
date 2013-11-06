angular.module 'addressbook', []

angular.module 'app', ['ngRoute', 'addressbook'],
  ['$routeProvider', '$locationProvider', ($routeProvider) ->
      $routeProvider
      .when '/addresses',
        templateUrl: 'views/addresses.html'
        controller: 'filterController'
        resolve:
          groups: ['$http', '$q', (http, q) -> http.get 'groups']
          countries: ['$http', (http) -> http.get 'countries']
      .when '/credits',
        templateUrl: 'views/credits.html'
      .otherwise
        redirectTo: '/addresses'
  ]