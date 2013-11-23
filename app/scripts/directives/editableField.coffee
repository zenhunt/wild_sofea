angular.module('addressbook')
  .directive 'editableField', ->
    restrict: 'A'
    scope: {
      for: '@'
      text: '@'
      editable: '@'
      label: '@'
    }
    transclude: true
    template:
      '<label for="{{for}}">{{label}}</label>' +
      '<span ng-show="editable" ng-transclude></span>' +
      '<span ng-hide="editable">{{text}}</span>'
