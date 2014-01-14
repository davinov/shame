db = require '../shameDB'
_ = require 'underscore'

Quote = {}

Quote.list = (req, res, next) ->
  db.view 'quote/all',
    limit: 100
    descending: true
  , (err, data) ->
    return res.send err if err
    res.send _.pluck data, 'value'

Quote.get = (req, res, next) ->
  db.get req.params.id, (err, data) ->
    return res.send err if err
    req.quote = data
    next()

Quote.send = (req, res, next) ->
  res.send req.quote

Quote.ensureReporter = (req, res, next) ->
  return res.send 401, "You can't modify or delete a quote that you haven't reported." if req.user.id != req.quote.reportedBy
  next()

Quote.add = (req, res, next) ->
  newQuote = req.body
  newQuote.creationDate = new Date()
  newQuote.updateDate = newQuote.creationDate
  newQuote.reportedBy = req.user.id
  newQuote.type = "quote"
  db.save newQuote, (err, data) ->
    return res.send 400, err if err
    req.quote = data
    next()

Quote.save = (req, res, next) ->
  updatedQuote = req.body
  updatedQuote.updateDate = new Date()
  db.merge req.quote.id, updatedQuote, (err, data) ->
    return res.send err if err
    req.quote = data
    next()

Quote.delete = (req, res, next) ->
  console.log req.quote
  db.remove req.quote.id, (err, data) ->
    return res.send err if err
    req.quote = data
    next()

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
            forbidden: 'Quote must not be empty'
        # should have a creation date
        if not newDoc.creationDate?
          throw
            forbidden: 'The creation date should not be empty'
        # should have been reported by someone
        if not newDoc.reportedBy?
          throw
            forbidden: 'You must be authenticated to submit a quote'
        # should have an author
        if not newDoc.author?
          throw
            forbidden: 'Invalid author: did you choose it from the list?'
        # should have an author's name
        if not newDoc.author.name?
          throw
          forbidden: 'Invalid author\'s name'
        # should have an author's id
        if not newDoc.author.id?
          throw
          forbidden: 'Invalid author\'s facebook id'

module.exports = Quote
