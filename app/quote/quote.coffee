angular
  .module("shame.quote", [
    "alert"
    "ngRoute"
    "ngResource"
  ])
  .config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when('/quote/:id', 
      templateUrl: 'quote/quote.html'
      controller: 'quoteController'
    )
  ])
  .controller("quoteController", ["$scope", "$routeParams", "Quote", ($scope, $routeParams, Quote) ->
      $scope.quote ?= new Quote()
      $scope.quote._id ?= $routeParams.id
      $scope.quote.$get()

      $scope.delete = () ->
        $scope.quote.$delete (res) ->
          $scope.alert =
            type: "success"
            message: "This quote have been successfully forgotten!"
        , (err) ->
          $scope.alert =
            type: "error"
            message: err.reason
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
