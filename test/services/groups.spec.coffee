describe 'groups', ->

  groups = null
  $httpBackend = null
  allGroups = [{}, {}, {}]

  beforeEach ->
    module 'addressbook'

    inject (_groups_, _$httpBackend_) ->
      groups = _groups_
      $httpBackend = _$httpBackend_

    $httpBackend.when('GET', 'groups/list').respond allGroups

  describe 'loadAll', ->

    it 'should asynchronously load all groups', ->
      groups.loadAll()

      expect(groups.all).not.toBeDefined()
      $httpBackend.flush()
      expect(groups.all).toEqual allGroups

    it 'should initialize the selectable groups with all retrieved groups except the first one', ->
      groups.loadAll()

      $httpBackend.flush()
      expect(groups.selectable.length).toEqual allGroups.length - 1