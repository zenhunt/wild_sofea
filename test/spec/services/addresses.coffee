describe 'addresses', ->

  addresses = null
  $httpBackend = null
  allAddresses = [
    {
      country: 'a'
      group: 'a'
      field1: new Date()
      field2: 'test1'
    },
    {
      country: 'b'
      group: 'b'
      field1: new Date(0)
      field2: 'test2'
    },
    {
      country: 'c'
      group: 'c'
      field1: new Date(100000000000)
      field2: 'test3'
    }
  ]

  beforeEach ->
    module 'addressbook'

    inject (_addresses_, _$httpBackend_) ->
      addresses = _addresses_
      $httpBackend = _$httpBackend_

    $httpBackend.when('GET', 'addresses/list').respond allAddresses

  describe 'loadAll()', ->

    beforeEach ->
      addresses.loadAll()

    it 'should asynchronously load all addresses', ->
      expect(addresses.all).not.toBeDefined()
      $httpBackend.flush()
      expect(addresses.all).toBe allAddresses

    it 'should initialize the filtered addresses with a copy of the retrieved addresses', ->
      $httpBackend.flush()
      expect(addresses.filtered).not.toBe allAddresses
      expect(addresses.filtered).toEqual allAddresses

    it 'should pass unique ids to all entries', ->
      $httpBackend.flush()
      allAddresses.forEach (addr) ->
        expect(addr.id).toBeDefined()
        expect(allAddresses.filter((other) -> other.id == addr.id).length).toEqual 1

  describe 'filter', ->

    beforeEach ->
      addresses.loadAll()
      $httpBackend.flush()

    it 'should save the filtered addresses in the field "filtered"', ->
      filtered = addresses.filter({})
      expect(filtered).toBe addresses.filtered

    it 'should filter by countries', ->
      filtered = addresses.filter country: 'a'
      expect(filtered.length).toEqual 1
      expect(filtered[0].country).toEqual 'a'

    it 'should accept "" for countries', ->
      filtered = addresses.filter country: ''
      expect(filtered.length).toEqual 3

    it 'should filter by groups', ->
      filtered = addresses.filter group: 'a'
      expect(filtered.length).toEqual 1
      expect(filtered[0].country).toEqual 'a'

    it 'should accept "" for groups', ->
      filtered = addresses.filter group: ''
      expect(filtered.length).toEqual 3

    it 'should filter by query (date)', ->
      filtered = addresses.filter query: '1970'
      expect(filtered.length).toEqual 1
      expect(filtered[0].field1).toEqual new Date(0)

    it 'should filter by query', ->
      filtered = addresses.filter query: 'test1'
      expect(filtered.length).toEqual 1
      expect(filtered[0].field2).toEqual 'test1'

    it 'should filter case insensitively by query', ->
      filtered = addresses.filter query: 'Test1'
      expect(filtered.length).toEqual 1
      expect(filtered[0].field2).toEqual 'test1'

    it 'should filter by query and all query tokens must be contained in at least one field', ->
      filtered = addresses.filter query: '1970 test2'
      expect(filtered.length).toEqual 1
      expect(filtered[0].field2).toEqual 'test2'

      filtered = addresses.filter query: '1970 test1'
      expect(filtered.length).toEqual 0

    it 'should accept "" for query', ->
      filtered = addresses.filter query: ''
      expect(filtered.length).toEqual 3