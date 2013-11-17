describe 'listController', ->

  scope = null
  addresses =
    filtered: [{}, {}]

  beforeEach module('addressbook')

  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    $controller 'listController',
      $scope: scope,
      addresses: addresses

  it 'should add the filtered addresses to the scope', ->
    expect(scope.addresses).toBe addresses.filtered

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