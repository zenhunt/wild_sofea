angular.module('addressbook')
  .factory 'addresses', ['$http', ($http) ->
    service =
      fields: ['forename', 'lastname', 'email', 'phone', 'street', 'zipcode', 'city']
      filter: (filter) -> null
      loadAll: ->
        $http.get('addresses/list').then (res) ->
          service.all = res.data
          service.filtered = angular.copy service.all

    service
  ]