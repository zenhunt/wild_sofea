describe 'countries', ->

  countries = null
  $httpBackend = null
  allCountries = [{}, {}, {}]

  beforeEach ->
    module 'addressbook'

    inject (_countries_, $injector) ->
      countries = _countries_
      $httpBackend = $injector.get '$httpBackend'

    $httpBackend.when('GET', 'countries/list').respond allCountries

  it 'should asynchronously load all countries', ->
    expect(countries.all).not.toBeDefined()
    $httpBackend.flush()
    expect(countries.all).toBe allCountries

  it 'should initialize the selectable countries with all retrieved countries except the first one', ->
    $httpBackend.flush()
    expect(countries.selectable.length).toEqual allCountries.length - 1