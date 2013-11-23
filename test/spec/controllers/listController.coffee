describe 'listController', ->

  scope = null
  addresses = null

  beforeEach module('addressbook')

  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    addresses =
      filtered: [{id: 0}, {id: 1}, {id: 2}]
      all: [{id: 0}, {id: 1}, {id: 2}, {id: 3}]
    $controller 'listController',
      $scope: scope,
      addresses: addresses

  it 'should add the filtered addresses to the scope', ->
    expect(scope.getAddresses()).toBe addresses.filtered

  describe 'scope.toggleDetails(addr)', ->

    it 'should set the details flag of the address to true', ->
      scope.toggleDetails addresses.filtered[0]
      expect(addresses.filtered[0].details).toBe true

    it 'should remove the details flag of previous selected address to false', ->
      scope.toggleDetails addresses.filtered[0]
      scope.toggleDetails addresses.filtered[1]
      expect(addresses.filtered[1].details).toBe true
      expect(addresses.filtered[0].details).not.toBeDefined()

    it 'should remove the details flag if it was true before', ->
      scope.toggleDetails addresses.filtered[0]
      scope.toggleDetails addresses.filtered[0]
      expect(addresses.filtered[0].details).toBe false

  describe 'scope.delete(id)', ->

    it 'should delete the address from the filtered addresses', ->
      scope.delete(0)
      expect(addresses.filtered.length).toEqual 2
      expect(addresses.filtered).toEqual [{id: 1}, {id: 2}]

    it 'should delete the address from all addresses', ->
      scope.delete(1)
      expect(addresses.all.length).toEqual 3
      expect(addresses.all).toEqual [{id: 0}, {id: 2}, {id: 3}]

    it 'should be able to delete multiple addresses', ->
      scope.delete([0, 2])
      expect(addresses.filtered.length).toEqual 1
      expect(addresses.all.length).toEqual 2
      expect(addresses.filtered).toEqual [{id: 1}]
      expect(addresses.all).toEqual [{id: 1}, {id: 3}]