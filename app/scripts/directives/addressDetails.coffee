angular.module('addressbook')
  .directive 'addressDetails', ->
    restrict: 'A'
    templateUrl: 'templates/addressDetails.html'
    controller: 'editController'
    compile: ($element) -> $element.addClass 'details'