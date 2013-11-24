angular.module('addressbook')
  .directive 'addressFilter', ->
    restrict: 'A'
    controller: 'filterController'
    scope: {}
    templateUrl: 'templates/addressFilter.html'
    link: ($scope) ->
      $scope.$watch 'filter', $scope.runFilter, true