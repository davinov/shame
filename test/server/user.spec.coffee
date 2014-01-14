should = require('chai').should
request = require 'superagent'
_ = require 'underscore'

module.exports = (url) ->
  ->

    describe 'GET /user', ->
      response = null
