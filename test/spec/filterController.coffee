describe 'filterController', ->

  scope = null
  countries = []
  groups = []

  beforeEach module('addressbook')

  beforeEach inject(($rootScope, $controller) ->
      scope = $rootScope.$new()
      $controller 'filterController', {$scope: scope, countries: countries, groups: groups}
  )

  it 'should fill the scope with countries and groups', ->
    expect(scope.countries).toBe(countries)
    expect(scope.groups).toBe(groups)

  it 'should fill scope.filter with default group and country', ->
    expect(scope.filter.country).toBeDefined()
    expect(scope.filter.group).toBeDefined()