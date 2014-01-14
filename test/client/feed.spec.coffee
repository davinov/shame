'use strict'

describe 'feed', ->

  beforeEach module 'shame.feed'

  describe 'controller', ->

    it 'should make scope testable', inject ($rootScope, $controller) ->
      scope = $rootScope.$new()
      ctrl = $controller 'feedController',
        $scope: scope
      should.exist scope.quotes
