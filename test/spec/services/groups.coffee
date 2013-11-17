describe 'groups', ->

  groups = null
  $httpBackend = null
  allGroups = [{}, {}, {}]

  beforeEach ->
    module 'addressbook'

    inject (_groups_, $injector) ->
      groups = _groups_
      $httpBackend = $injector.get '$httpBackend'

    $httpBackend.when('GET', 'groups/list').respond allGroups

  it 'should asynchronously load all groups', ->
    expect(groups.all).not.toBeDefined()
    $httpBackend.flush()
    expect(groups.all).toBe allGroups

  it 'should initialize the selectable groups with all retrieved groups except the first one', ->
    $httpBackend.flush()
    expect(groups.selectable.length).toEqual allGroups.length - 1