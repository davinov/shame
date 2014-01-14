should = require('chai').should
request = require 'supertest'
_ = require 'underscore'

module.exports = (url) ->
  ->

    describe 'GET /user', ->
      response = null
