angular
  .module("shame.header", [
  ])
  .controller("headerController", ["$scope", "$http", ($scope, $http) ->
      0
    ]
  )
  .directive("shameHeader", ->
      restrict: 'E'
      templateUrl: 'header/header.html'
      controller: 'headerController'
      scope:
        user: "="
  )
