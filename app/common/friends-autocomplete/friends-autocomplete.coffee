angular
.module('shame.friends-autocomplete', [
    'ui.bootstrap'
    'ezfb'
  ])
.controller('friendsAutocompleteController', [ '$scope', '$FB', ($scope, $FB) ->
    $FB.getLoginStatus (res) ->
      if res.status != "connected"
        throw $scope.alert =
          type: "error"
          msg: "You're not connected with Facebook."
      $FB.api "/me/friends", (data) ->
        $scope.friends = data.data
  ])
.directive('friendsAutocomplete', ->
    restrict: 'E'
    templateUrl: 'common/friends-autocomplete/friends-autocomplete.html'
    controller: 'friendsAutocompleteController'
    scope:
      model: "="
    replace: true
  )
