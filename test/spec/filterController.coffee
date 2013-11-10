describe 'filterController', ->

  scope = null
  countries = []
  groups = []
  addresses = []

  beforeEach module('addressbook')

  beforeEach inject(($rootScope, $controller) ->
    countries = ['all', 'c1']
    groups = ['all', 'g1']
    addresses = [{},{},{}]
    scope = $rootScope.$new()
    $controller 'filterController',
      $scope: scope,
      countries: countries,
      groups: groups,
      addresses: addresses
  )

  it 'should fill the scope with countries, groups and addresses', ->
    expect(scope.filterCountries).toBe(countries)
    expect(scope.editCountries.length).toBe(countries.length - 1)
    expect(scope.filterGroups).toBe(groups)
    expect(scope.editGroups.length).toBe(groups.length - 1)
    expect(scope.addresses).toEqual(addresses)

  it 'should fill scope.filter with default group and country', ->
    expect(scope.filter.country).toBeDefined()
    expect(scope.filter.group).toBeDefined()

  describe 'scope.toggleDetails(addr)', ->

    it 'should set the details flag of the address to true', ->
      scope.toggleDetails addresses[0]
      expect(addresses[0].details).toBe true

    it 'should remove the details flag of previous selected address to false', ->
      scope.toggleDetails addresses[0]
      scope.toggleDetails addresses[1]
      expect(addresses[1].details).toBe true
      expect(addresses[0].details).not.toBeDefined()

    it 'should remove the details flag if it was true before', ->
      scope.toggleDetails addresses[0]
      scope.toggleDetails addresses[0]
      expect(addresses[0].details).toBe false