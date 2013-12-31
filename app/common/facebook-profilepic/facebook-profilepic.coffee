angular
.module('shame.facebook-profilepic', [])
.directive('profilePic', ->
    restrict: 'E'
    templateUrl: 'common/facebook-profilepic/facebook-profilepic.html'
    scope:
      facebookId: "="
      size: "="
    replace: false
  )
