db = require '../shameDB'
_ = require 'underscore'

Quote = {}

Quote.list = (req, res, next) ->
  db.all (err, data) ->
    throw res.send err if err
    res.send _.map data, (doc) ->
      { _id: doc.id }

Quote.get = (req, res, next) ->
  db.get req.params.id, (err, data) ->
    throw res.send err if err
    res.send data

Quote.add = (req, res, next) ->
  db.save req.body, (err, data) ->
    throw res.send 400, err if err
    res.send data

Quote.save = (req, res, next) ->
  db.merge req.params.id, req.body, (err, data) ->
    throw res.send err if err
    res.send data

Quote.delete = (req, res, next) ->
  db.remove req.params.id, (err, data) ->
    throw res.send err if err
    res.send data

module.exports = Quote
