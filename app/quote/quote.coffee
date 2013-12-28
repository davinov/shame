angular
  .module("shame.quote", [
    "shame.alert"
    "ngRoute"
    "ngResource"
    "shame.moment"
  ])
  .config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when('/quote/:id', 
      templateUrl: 'quote/quote.html'
      controller: 'quoteController'
    )
  ])
  .controller("quoteController", ["$scope", "$routeParams", "Quote", ($scope, $routeParams, Quote) ->
      $scope.quote ?= new Quote($scope.quote)
      $scope.quote._id ?= $routeParams.id
      $scope.quote.$get() if !$scope.quote.text

      $scope.delete = () ->
        $scope.quote.$delete (res) ->
          $scope.alert =
            type: "success"
            message: "This quote have been successfully forgotten!"
        , (err) ->
          $scope.alert =
            type: "error"
            message: err.data
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
            message: "Thank you for adding this quote!"
          $scope.quote = new Quote()
        , (err) ->
          $scope.alert =
            type: "error"
            message: "Error"
          $scope.alert.message += ": " + err.data.reason if err.data.reason
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
