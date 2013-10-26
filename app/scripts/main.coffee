app = angular.module 'addressbook', []

app.controller 'testController', ['$scope', (scope) ->
  scope.title = 'Address book'
]