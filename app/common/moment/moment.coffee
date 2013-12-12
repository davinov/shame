angular
.module('shame.moment', [])
.directive 'timeAgo', ->
    restrict: 'E'
    templateUrl: 'common/moment/moment.html'
    scope:
      date: "="
.filter 'ago', () ->
  (date) ->
    moment(date).fromNow() if date
