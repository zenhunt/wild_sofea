describe 'editableField', ->

  $scope = null
  element = null
  fetchTextContainer = -> element.children '*:not([ng-transclude]):not(label)'
  fetchTranscludeContainer = -> element.children '[ng-transclude]'

  beforeEach ->
    module 'addressbook'
    inject ($compile, $rootScope) ->
      $scope = $rootScope
      element = $('<div editable-field for="{{for}}" label="{{label}}" text="{{text}}" editable="{{edit}}"><input id="test" type="text"/></div>')
      $compile(element) $scope

  it 'should add a label for the field', ->
    $scope.for = 'test'
    $scope.$digest()

    expect(element.find('label').size()).toEqual 1
    expect(element.find('label').attr('for')).toEqual $scope.for

  it 'should transclude the nested elements', ->
    transcluded = element.find('[ng-transclude]').children()

    expect(transcluded.size()).toEqual 1
    expect(transcluded.is('input[type="text"]#test')).toBe true

  it 'should fill in the correct text', ->
    $scope.text = 'test'
    $scope.$digest()
    expect(fetchTextContainer().text()).toEqual $scope.text

  it 'should show the text and hide the transcluded content when editable is false', ->
    $scope.edit = false
    $scope.$digest()

    expect(fetchTextContainer().is('.ng-hide')).toBe false
    expect(fetchTranscludeContainer().is('.ng-hide')).toBe true

  it 'should hide the text and show the transcluded content when editable is true', ->
    $scope.edit = true
    $scope.$digest()

    expect(fetchTextContainer().is('.ng-hide')).toBe true
    expect(fetchTranscludeContainer().is('.ng-hide')).toBe false