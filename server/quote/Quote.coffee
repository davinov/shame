db = require '../shameDB'
_ = require 'underscore'

Quote = {}

Quote.list = (req, res, next) ->
  db.view 'quote/all', (err, data) ->
    return res.send err if err
    res.send _.map data, (doc) ->
      { _id: doc.id }

Quote.get = (req, res, next) ->
  db.get req.params.id, (err, data) ->
    return res.send err if err
    res.send data

Quote.add = (req, res, next) ->
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
        map: (doc) ->
          emit doc if doc.type == 'quote'
      byAuthor:
        map: (doc) ->
          emit doc if doc.type == 'quote' and doc.author == 'Author'
    validate_doc_update: (newDoc, oldDoc) ->
      # should have a text
      if not newDoc.text? or not newDoc.text or newDoc.text == ''
        throw
          forbidden: 'Quote\ must\ not\ be\ empty'
      # should have a creation date
      if not newDoc.creationDate?
        throw
          forbidden: 'The\ creation\ date\ should\ not\ be\ empty'

module.exports = Quote
