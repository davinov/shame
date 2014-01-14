should = require('chai').should
request = require 'supertest'
_ = require 'underscore'

module.exports = (url) ->
  ->
    quote = undefined

    # Get a sample quote from the feed
    before (done) ->
      request(url)
      .get('/feed')
      .redirects(2)
      .end (err, res) ->
        quote = res.body[0]
        done()

    describe 'GET /quote', ->
      response = undefined

      before (done) ->
        request(url)
        .get('/quote/'+quote._id)
        .redirects(2)
        .end (err, res) ->
          response = res
          done()

      it 'should respond', (done) ->
        response.should.have.status 200
        done()

      it 'should contain a text', (done) ->
        response.body.text.should.not.be.empty
        done()

      it 'should contain an author', (done) ->
        response.body.author.should.be.ok
        response.body.author.should.have.properties [
          'id'
          'name'
        ]
        done()
