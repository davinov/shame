db = require '../shameDB'
_ = require 'underscore'

User = {}

User.list = (req, res, next) ->
  db.all (err, data) ->
    res.send _.map data, (doc) ->
      { _id: doc.id }

User.get = (req, res, next) ->
  console.log req.params.id
  db.get req.params.id, (err, data) ->
    res.send data

User.add = (req, res, next) ->
  db.save req.body, (err, data) ->
    res.send data

User.save = (req, res, next) ->
  db.merge req.params.id, req.body, (err, data) ->
    res.send data

User.delete = (req, res, next) ->
  console.log req.params.id
  db.remove req.params.id, (err, data) ->
    res.send data

module.exports = User
