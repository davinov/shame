shameApi = require '../../server/shameApi'

feedSpec = require './feed.spec'
quoteSpec = require './quote.spec'
userSpec = require './user.spec'

describe 'Shame API', ->
  port = 9999
  url = 'http://localhost:' + port

  before (done) ->
    shameApi.start port, '', done

  describe 'Feed', feedSpec url

  describe 'Quote', quoteSpec url

  describe 'User', userSpec url
