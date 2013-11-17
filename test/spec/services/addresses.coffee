describe 'addresses', ->

  addresses = null
  $httpBackend = null
  allAddresses = [{}, {}, {}]

  beforeEach ->
    module 'addressbook'

    inject (_addresses_, $injector) ->
      addresses = _addresses_
      $httpBackend = $injector.get '$httpBackend'

    $httpBackend.when('GET', 'addresses/list').respond allAddresses

  it 'should asynchronously load all addresses', ->
    expect(addresses.all).not.toBeDefined()
    $httpBackend.flush()
    expect(addresses.all).toBe allAddresses

  it 'should initialize the filtered addresses with a copy of the retrieved addresses', ->
    $httpBackend.flush()
    expect(addresses.filtered).not.toBe allAddresses
    expect(addresses.filtered).toEqual allAddresses