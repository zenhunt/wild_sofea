describe 'filterController', ->

  scope = null
  countries = []
  groups = []
  addresses = []

  beforeEach module('addressbook')

  beforeEach inject ($rootScope, $controller) ->
    countries =
      all: ['all', 'c1']
    groups =
      all: ['all', 'g1']
    addresses =
      all: [{}, {}, {}]
    scope = $rootScope.$new()
    $controller 'filterController',
      $scope: scope,
      countries: countries,
      groups: groups,
      addresses: addresses

  it 'should fill the scope with countries, groups and addresses', ->
    expect(scope.countries).toBe countries.all
    expect(scope.groups).toBe groups.all

  it 'should fill scope.filter with default group and country', ->
    expect(scope.filter.country).toBeDefined()
    expect(scope.filter.group).toBeDefined()