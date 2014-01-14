should = require('chai').should
request = require 'supertest'
_ = require 'underscore'

module.exports = (url) ->
  ->
    describe 'GET /feed', ->
      response = null

      before (done) ->
        request(url)
        .get('/feed')
        .redirects(2)
        .end (err, res) ->
          response = res
          done()

      it 'should respond', (done) ->
        response.should.have.status 200
        done()

      it 'should be an array', (done) ->
        response.body.should.be.instanceof Array
        done()
