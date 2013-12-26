db = require '../shameDB'
_ = require 'underscore'

User = {}

User.findOrCreate = (profile) ->
  throw "No profile information" if not profile?
  db.view 'user/byFacebookId', { key: profile.id }, (err, data) ->
    return console.log data if err
    if data.length == 0
      newUser =
        facebookId: profile.id
        displayName: profile.displayName
        registrationDate: new Date()
        type: 'user'
      newUser.photo = profile.photos[0].value if profile.photos[0]? if profile.photos?
      newUser.updateDate = newUser.registrationDate
      db.save newUser, (err, data) ->
        return console.log data if err
        return data

User.me = (req, res, next) ->
  if req.user
    req.params.id = req.user.id
    return User.get req, res, next
  return res.send 401

User.get = (req, res, next) ->
  db.view 'user/byFacebookId', { key: req.params.id }, (err, data) ->
    return res.send err if err
    res.send _.pluck(data, 'value')[0]

# Populate design document
db.save '_design/user',
  views:
    all:
      map: (doc) ->
        emit doc._id, doc if doc.type == 'user'
    byFacebookId:
      map: (doc) ->
        emit doc.facebookId, doc if doc.type == 'user'
  validate_doc_update: (newDoc, oldDoc) ->
    if newDoc.type == 'user'
      # should have an id
      if not newDoc.facebookId? or not newDoc.facebookId or newDoc.facebookId == ''
        throw
        forbidden: 'User\ must\ have\ a\ Facebook\ id'
      # should have a display name
      if not newDoc.displayName? or not newDoc.displayName or newDoc.displayName == ''
        throw
        forbidden: 'User\ must\ have\ a\ display\ name'
      # should have a creation date
      if not newDoc.registrationDate?
        throw
        forbidden: 'The\ registration\ date\ should\ not\ be\ empty'

module.exports = User
