"use strict"

angular
  .module("shame", [
      "ng"
      "ngCookies"
      "ngRoute"
      "shame.feed"
    ])
  .config [
    "$routeProvider"
    "$httpProvider"
    "$compileProvider"
    ($routeProvider, $httpProvider, $compileProvider) ->
      $compileProvider.aHrefSanitizationWhitelist(/^\s*(mailto|tel|http):/)
      $routeProvider
        .otherwise { redirectTo: "/feed" }

      delete $httpProvider.defaults.headers.common["X-Requested-With"]
  ]
  