angular.module('addressbook')
  .factory 'countries', ['$http', ($http) ->
    service =
      loadAll: ->
        $http.get('countries/list').then (res) ->
          service.all = res.data
          service.selectable = service.all.slice 1
  ]