"use strict"

angular
  .module("shame", [
      "ng"
      "ngCookies"
      "ngRoute"
      "ezfb"
      "shame.header"
      "shame.feed"
      "shame.user"
    ])
  .config [
    "$routeProvider"
    "$httpProvider"
    "$compileProvider"
    "$FBProvider"
    ($routeProvider, $httpProvider, $compileProvider, $FBProvider) ->
      $compileProvider.aHrefSanitizationWhitelist(/^\s*(mailto|tel|http):/)
      $routeProvider
        .otherwise { redirectTo: "/feed" }

      delete $httpProvider.defaults.headers.common["X-Requested-With"]

      $FBProvider.setInitParams
        appId: '186311504892782'
]
