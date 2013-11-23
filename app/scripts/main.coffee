angular.module 'addressbook', []

angular.module 'app', ['ngRoute', 'addressbook'],
  ['$routeProvider', ($routeProvider) ->
    $routeProvider
    .when '/addresses',
      templateUrl: 'views/addresses.html'
      resolve:
        groupsData: ['groups', (groups) -> groups.loadAll()]
        countriesData: ['countries', (countries) -> countries.loadAll()]
        addressesData: ['addresses', (addresses) -> addresses.loadAll()]
    .when '/credits',
      templateUrl: 'views/credits.html'
    .otherwise
      redirectTo: '/addresses'
  ]