describe 'listController', ->

  scope = null
  countries =
    selectable: []
  groups =
    selectable: []

  beforeEach module('addressbook')

  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    $controller 'editController',
      $scope: scope
      countries: countries
      groups: groups

  it 'should add selectable countries and groups to the scope', ->
    expect(scope.countries).toBe countries.selectable
    expect(scope.groups).toBe groups.selectable