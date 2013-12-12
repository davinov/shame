angular
.module('shame.alert', [])
.directive 'alert', ->
    restrict: 'E'
    templateUrl: 'common/alert/alert.html'
    scope:
      alert: "="
