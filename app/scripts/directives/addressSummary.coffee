angular.module('addressbook')
  .directive 'addressSummary', ->
    restrict: 'A'
    templateUrl: 'templates/addressSummary.html'