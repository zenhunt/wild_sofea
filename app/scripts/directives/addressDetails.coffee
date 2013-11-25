angular.module('addressbook')
  .directive 'addressDetails', ->
    restrict: 'A'
    scope:
      addr: '='
      delete: '&'
      onSave: '&'
      add: '@'
    templateUrl: 'templates/addressDetails.html'
    controller: 'editController'
    compile: ($element) -> $element.addClass 'details'