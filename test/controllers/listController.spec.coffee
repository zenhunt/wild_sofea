describe 'listController', ->

  scope = null
  addresses = null

  beforeEach module('addressbook')

  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    addresses =
      filtered: [{id: 0}, {id: 1}, {id: 2}]
      all: [{id: 0}, {id: 1}, {id: 2}, {id: 3}]
      delete: jasmine.createSpy 'delete'
      selectAll: jasmine.createSpy 'selectAll'
      allSelected: jasmine.createSpy 'allSelected'
      filter: jasmine.createSpy 'runFilter'
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

  describe 'scope.totalCount()', ->

    it 'should return the number of all addresses', ->
      expect(scope.totalCount()).toEqual addresses.all.length

  describe 'scope.delete(id)', ->

    it 'should delegate to addresses.delete(id)', ->
      scope.delete 0
      expect(addresses.delete).toHaveBeenCalledWith 0

  describe 'scope.delete()', ->

    it 'should delegate to addresses.delete()', ->
      scope.delete()
      expect(addresses.delete).toHaveBeenCalled()

  describe 'scope.selectAll()', ->

    it 'should delegate to addresses.selectAll()', ->
      scope.selectAll()
      expect(addresses.selectAll).toHaveBeenCalled()

  describe 'scope.allSelected()', ->

    it 'should delegate to addresses.allSelected()', ->
      scope.allSelected()
      expect(addresses.allSelected).toHaveBeenCalled()

  describe 'toggleAdd()', ->

    it 'should set scope.adding to true if it was falsy', ->
      scope.toggleAdd()
      expect(scope.adding).toBe true

    it 'should set scope.adding to false if it was truthy', ->
      scope.adding = true
      scope.toggleAdd()
      expect(scope.adding).toBe false

    it 'should set scope.toAdd = {} if scope.adding was falsy', ->
      scope.toggleAdd()
      expect(scope.toAdd).toEqual {}

  describe 'add()', ->

    it 'should add the newly added address to the list of all addresses', ->
      scope.toggleAdd()
      scope.add()
      expect(addresses.all.length).toEqual 5

    it 'should refilter all addresses', ->
      scope.toggleAdd()
      scope.add()
      expect(addresses.filter).toHaveBeenCalled()

    it 'should set the id', ->
      scope.toggleAdd()
      toAdd = scope.toAdd
      scope.add()
      expect(toAdd.id).toEqual 4

    it 'should set toAdd to a new object', ->
      scope.toggleAdd()
      toAdd = scope.toAdd
      scope.add()
      expect(scope.toAdd).not.toBe toAdd