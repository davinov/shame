angular
  .module("shame.header", [
    "shame.user"
  ])
  .controller("headerController", [ "$scope", "User", ($scope, User) ->
      User.me (data) ->
        $scope.user = data
  ]
  )
  .directive("shameHeader", ->
      restrict: 'E'
      templateUrl: 'header/header.html'
      controller: 'headerController'
  )
