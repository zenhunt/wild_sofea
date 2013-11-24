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
      delete: (id) ->
        if id?
          idx = 0
          while idx < service.all.length
            service.filtered.splice idx, 1 if service.filtered[idx] && service.filtered[idx].id == id
            return service.all.splice idx, 1 if service.all[idx].id == id
            idx++
        else
          indexes = []
          service.filtered.forEach (addr, idx) ->
            if addr.selected
              idx -= indexes.length
              indexes.push idx
              while idx < service.all.length
                if service.all[idx].id == addr.id
                  service.all.splice idx, 1
                  break
                idx++
          indexes.forEach (idx) -> service.filtered.splice idx, 1
      selectAll: ->
        allSelected = service.allSelected()
        service.filtered.forEach (addr) -> addr.selected = !allSelected
      allSelected: ->
        service.filtered.every (addr) -> addr.selected
  ]