'use strict'

describe 'quote', ->

  beforeEach module 'shame.quote'

  describe 'controller', ->
    [Quote, quoteController, scope] = [undefined]

    before ->
      inject ($rootScope, $controller) ->
        scope = $rootScope.$new()
        quoteController = $controller 'quoteController',
          $scope: scope
        console.log $controller

    it 'should make scope testable', inject ($rootScope, $controller) ->
      scope = $rootScope.$new()
      ctrl = $controller 'quoteController',
        $scope: scope
      should.exist scope.quote

    it 'should have a quote object', ->
      scope.quote.should.be.ok

#  describe 'directive', ->
#    [$compile, quoteElement, scope] = [undefined]
#
#    before ->
#      inject ($rootScope, $directive, _$compile_) ->
#        scope = $rootScope.$new()
#        quoteController = $controller 'quoteController',
#          $scope: scope
#        $compile = _$compile_
#        $compile '<shame-quote quote="{ id:10, text:\'nabla\', author:\'you\' }"></shame-quote>'
#
#    it 'should have a text', ->
#      0
