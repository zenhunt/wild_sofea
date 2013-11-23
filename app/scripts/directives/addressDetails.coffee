angular.module('addressbook')
  .directive 'addressDetails', ->
    restrict: 'A'
    scope:
      addr: '='
      delete: '&'
      save: '&'
    templateUrl: 'templates/addressDetails.html'
    controller: 'editController'
    compile: ($element) -> $element.addClass 'details'