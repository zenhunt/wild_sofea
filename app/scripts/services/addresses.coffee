angular.module('addressbook')
  .factory 'addresses', ['$http', ($http) ->
    service =
      fields: ['forename', 'lastname', 'email', 'phone', 'street', 'zipcode', 'city']
      filter: (filter) ->
        service.filtered = service.all.filter (addr) ->
          (!filter.country || addr.country == filter.country) &&
          (!filter.group || addr.group == filter.group) &&
          (!filter.query || filter.query.split(' ').every (token) ->
              Object.keys(addr).some (field) ->
                addr[field].toString().match new RegExp(".*#{token}.*", 'i')
          )
      loadAll: ->
        $http.get('addresses/list').then (res) ->
          res.data.forEach (addr, idx) -> addr.id = idx
          service.all = res.data
          service.filtered = angular.copy service.all
  ]