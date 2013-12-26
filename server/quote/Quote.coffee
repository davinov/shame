db = require '../shameDB'
_ = require 'underscore'

Quote = {}

Quote.list = (req, res, next) ->
  db.view 'quote/all' ,
    limit: 100
    descending: true
  , (err, data) ->
    return res.send err if err
    res.send _.pluck data, 'value'

Quote.get = (req, res, next) ->
  db.get req.params.id, (err, data) ->
    return res.send err if err
    res.send data

Quote.add = (req, res, next) ->
  return res.send 401 if not req.user?
  newQuote = req.body
  newQuote.creationDate = new Date()
  newQuote.updateDate = newQuote.creationDate
  newQuote.type = "quote"
  db.save newQuote, (err, data) ->
    return res.send 400, err if err
    res.send data

Quote.save = (req, res, next) ->
  updatedQuote = req.body
  updatedQuote.updateDate = new Date()
  db.merge req.params.id, updatedQuote, (err, data) ->
    return res.send err if err
    res.send data

Quote.delete = (req, res, next) ->
  db.remove req.params.id, (err, data) ->
    return res.send err if err
    res.send data

# Populate design document
db.save '_design/quote',
    views:
      all:
        descending: true
        map: (doc) ->
          emit doc.creationDate, doc if doc.type == 'quote'
      byAuthor:
        map: (doc) ->
          emit doc.author, doc if doc.type == 'quote'
    validate_doc_update: (newDoc, oldDoc) ->
      if newDoc.type == 'quote'
        # should have a text
        if not newDoc.text? or not newDoc.text or newDoc.text == ''
          throw
            forbidden: 'Quote\ must\ not\ be\ empty'
        # should have a creation date
        if not newDoc.creationDate?
          throw
            forbidden: 'The\ creation\ date\ should\ not\ be\ empty'

module.exports = Quote
