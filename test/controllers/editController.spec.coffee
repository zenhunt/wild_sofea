describe 'listController', ->

  scope = null
  countries =
    selectable: []
  groups =
    selectable: []
  editedAddress = null

  beforeEach module('addressbook')

  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    editedAddress =
      id: 0
      forename: 'test'
    scope.addr = editedAddress
    $controller 'editController',
      $scope: scope
      countries: countries
      groups: groups

  it 'should add selectable countries and groups to the scope', ->
    expect(scope.countries).toBe countries.selectable
    expect(scope.groups).toBe groups.selectable

  it 'should clone the address for presentation purposes', ->
    expect(scope.addressClone).toEqual scope.addr
    expect(scope.addressClone).not.toBe scope.addr

  describe 'edit()', ->

    it 'should change the edit state to true and create a new clone of the original address', ->
      oldClone = scope.addressClone
      scope.edit()
      expect(scope.editing).toBe true
      expect(scope.addressClone).not.toBe oldClone

  describe 'save()', ->

    it 'should change the original address', ->
      scope.addressClone.forename = 'test1'
      expect(scope.addressClone).not.toBe editedAddress
      expect(scope.addr.forename).toEqual 'test'
      scope.save()
      expect(scope.addr.forename).toEqual 'test1'
      expect(scope.editing).toBe false

    it 'should call scope.onSave(), if defined', ->
      scope.onSave = jasmine.createSpy 'onSave'
      scope.save()
      expect(scope.onSave).toHaveBeenCalled()