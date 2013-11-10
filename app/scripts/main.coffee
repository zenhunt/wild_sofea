angular.module 'addressbook', []

angular.module 'app', ['ngRoute', 'addressbook'],
  ['$routeProvider', ($routeProvider) ->

    httpGetWithInject = (src) -> ['$http', (http) -> http.get(src).then((res) -> res.data)]

    $routeProvider
    .when '/addresses',
      templateUrl: 'views/addresses.html'
      controller: 'filterController'
      resolve:
        groups: httpGetWithInject 'groups'
        countries: httpGetWithInject 'countries'
        addresses: httpGetWithInject 'addresses/list'
    .when '/credits',
      templateUrl: 'views/credits.html'
    .otherwise
      redirectTo: '/addresses'
  ]