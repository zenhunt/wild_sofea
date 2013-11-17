angular.module('addressbook')
  .factory 'groups', ['$http', ($http) ->
    service = {}

    $http.get('groups/list').then (res) ->
      service.all = res.data
      service.selectable = service.all.slice 1

    service
  ]