angular.module 'addressbook', []

angular.module 'app', ['ngRoute', 'addressbook'],
  ['$routeProvider', ($routeProvider) ->
    $routeProvider
    .when '/addresses',
      templateUrl: 'views/addresses.html'
      resolve:
        groupsData: ['groups', (groups) -> groups.all]
        countriesData: ['countries', (countries) -> countries.all]
        addressesData: ['addresses', (addresses) -> addresses.all]
    .when '/credits',
      templateUrl: 'views/credits.html'
    .otherwise
      redirectTo: '/addresses'
  ]