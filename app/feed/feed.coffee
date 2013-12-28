angular
  .module("shame.feed", [
    "shame.quote"
    "ngRoute"
  ])
  .config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when('/feed', 
      templateUrl:'feed/feed.html'
      controller:'feedController'
    )
  ])
  .controller("feedController", [
      "$scope"
      "Quote"
      ($scope, Quote) ->
        $scope.quotes = Quote.query();
    ]
  )
