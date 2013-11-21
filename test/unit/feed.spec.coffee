'use strict'

# jasmine specs for controllers go here

# TODO figure out how to test Controllers that use modules
describe "feed", ->

  beforeEach(module "shame.feed")

  describe "feedController", ->

    it "should make scope testable", inject ($rootScope, $controller) ->
      scope = $rootScope.$new()
      ctrl = $controller "feedController",
        $scope: scope,
      expect(scope.quotes).toBeDefined()
