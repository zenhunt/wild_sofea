describe 'countries', ->

  countries = null
  $httpBackend = null
  allCountries = [{}, {}, {}]

  beforeEach ->
    module 'addressbook'

    inject (_countries_, _$httpBackend_) ->
      countries = _countries_
      $httpBackend = _$httpBackend_

    $httpBackend.when('GET', 'countries/list').respond allCountries

  it 'should asynchronously load all countries', ->
    countries.loadAll()

    expect(countries.all).not.toBeDefined()
    $httpBackend.flush()
    expect(countries.all).toEqual allCountries

  it 'should initialize the selectable countries with all retrieved countries except the first one', ->
    countries.loadAll()

    $httpBackend.flush()
    expect(countries.selectable.length).toEqual allCountries.length - 1