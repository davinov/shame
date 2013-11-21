shameDB = require '../shameDB'
_ = require 'underscore'

Quote = {}

dbName = shameDB.dbPrefix+'quotes'
db = shameDB.database dbName
db.exists (err, exists) ->
  return console.log 'error', err if err
  return if exists
  console.log 'Creating database'+ shameDB.dbPrefix+'quotes'
  db.create()
  # populate design documents

Quote.list = (req, res, next) ->
  db.all (err, data) ->
    res.send _.map data, (doc) ->
      { _id: doc.id }

Quote.get = (req, res, next) ->
  console.log req.params.id
  db.get req.params.id, (err, data) ->
    res.send data

Quote.add = (req, res, next) ->
  db.save req.body, (err, data) ->
    res.send data

Quote.save = (req, res, next) ->
  db.merge req.params.id, req.body, (err, data) ->
    res.send data

Quote.delete = (req, res, next) ->
  console.log req.params.id
  db.remove req.params.id, (err, data) ->
    res.send data

module.exports = Quote
