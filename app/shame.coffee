"use strict"

angular
  .module("shame", [
      "ng"
      "ngCookies"
      "ngRoute"
      "shame.header"
      "shame.feed"
      "shame.user"
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
  