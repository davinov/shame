db = require '../shameDB'
_ = require 'underscore'

User = {}

User.list = (req, res, next) ->
  db.view 'user/all', (err, data) ->
    return res.send err if err
    res.send _.map data, (doc) ->
      { _id: doc.id }

User.get = (req, res, next) ->
  db.get req.params.id, (err, data) ->
    return res.send err if err
    res.send data

User.add = (newUser, next) ->
  newUser.type = "user"
  db.save newUser, (err, data) ->
    return next 400, err if err
    next data

User.save = (req, res, next) ->
  updatedUser = req.body
  updatedUser.updateDate = new Date()
  db.merge req.params.id, updatedUser, (err, data) ->
    return res.send err if err
    res.send data

User.delete = (req, res, next) ->
  db.remove req.params.id, (err, data) ->
    return res.send err if err
    res.send data

# Populate design document
db.save '_design/user',
    views:
      all:
        map: (doc) ->
          emit doc if doc.type == 'user'

module.exports = User
