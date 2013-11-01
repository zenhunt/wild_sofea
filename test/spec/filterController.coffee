describe 'filterController', ->

  scope = null

  beforeEach module('addressbook')

  beforeEach inject(($rootScope, $controller) ->
      scope = $rootScope.$new()
      $controller 'filterController', $scope: scope
  )

  it 'should fill the scope with countries and groups', ->
    expect(scope.countries).toBeDefined()
    expect(scope.groups).toBeDefined()

  it 'should fill scope.filter with default group and country', ->
    expect(scope.filter.country).toBeDefined()
    expect(scope.filter.group).toBeDefined()