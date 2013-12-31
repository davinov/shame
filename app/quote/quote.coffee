angular
  .module("shame.quote", [
    "ngRoute"
    "ngResource"
    "ui.bootstrap.alert"
    "ezfb"
    "shame.moment"
    "shame.friends-autocomplete"
    "shame.facebook-profilepic"
  ])
  .config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when('/quote/:id', 
      templateUrl: 'quote/quote.html'
      controller: 'quoteController'
    )
  ])
  .controller("quoteController", ["$scope", "$location", "$routeParams", "$FB", "Quote", ($scope, $location, $routeParams, $FB, Quote) ->
      $scope.quote ?= new Quote($scope.quote)
      $scope.quote._id ?= $routeParams.id
      $scope.quote.$get() if !$scope.quote.text
      $scope.url = $location.absUrl().replace /#.*/, "#/quote/" + $scope.quote._id
      $FB.getLoginStatus (res) ->
        if res.status != "connected"
          throw $scope.alert =
            type: "error"
            msg: "You're not connected with Facebook."

      $scope.delete = () ->
        $scope.quote.$delete (res) ->
          $scope.alert =
            type: "success"
            msg: "This quote have been successfully forgotten!"
        , (err) ->
          $scope.alert =
            type: "error"
            msg: err.data
    ]
  )
  .directive("shameQuote", ->
    return {
      restrict: 'E'
      templateUrl: 'quote/quote.html'
      controller: 'quoteController'
      scope:
        quote: "="
    }
  )
  .controller("newQuoteController", ["$scope", "$route", "Quote", ($scope, $route, Quote) ->
      $scope.quote = new Quote()
      $scope.send = () ->
        $scope.quote.$save (res) ->
          $scope.alert =
            type: "success"
            msg: "Thank you for adding this quote!"
          $scope.quote = new Quote()
        , (err) ->
          $scope.alert =
            type: "error"
            msg: "Error"
          $scope.alert.msg += ": " + err.data.reason if err.data.reason
    ]
  )
  .factory('Quote', [ '$resource', ($resource) ->
    return $resource 'quote/:_id',
        {
          text: '@text'
          author: '@author'
          _id: '@_id'
        },
        query:
          method: 'GET'
          url: '/feed'
          isArray: true
        get:
          method: 'GET'
        save:
          method: 'POST'
        delete:
          method: 'DELETE'
  ])
