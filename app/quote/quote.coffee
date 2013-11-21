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
          if res.ok
            $scope.alert =
              type: "success"
              message: "This quote have been successfully forgotten!"
          else
            $scope.alert =
              type: "error"
              message: "Error: " + res.reason
        , (err) ->
          $scope.alert =
            type: "error"
            message: "Error: " + err
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
          if res.ok
            $scope.alert =
              type: "success"
              message: "Thank you for adding this quote!"
            $scope.quote = new Quote()
          else
            $scope.alert =
              type: "error"
              message: "Error: " + res.reason
        , (err) ->
          $scope.alert =
            type: "error"
            message: "Error: " + err
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
