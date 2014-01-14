'use strict'

# http://docs.angularjs.org/guide/dev_guide.e2e-testing 
describe 'shame', ->
  beforeEach ->
    browser().navigateTo '/'

  it 'should automatically redirect to /feed when location hash/fragment is empty', ->
    expect(browser().location().url()).toBe '/feed'

  describe 'feed', ->
    beforeEach ->
      browser().navigateTo '#/feed'

    it 'should render feed when user navigates to /feed', ->
      expect element('.feed')
        .toBe()
