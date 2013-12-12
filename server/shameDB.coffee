cradle = require 'cradle'
config = require('config').database

cradle.setup {
  host: config.host
  port: config.port
  auth:
    username: config.user
    password: config.password
}

dbName = config.prefix+'-quotes'
couchDB = new(cradle.Connection)()
shameDB = couchDB.database dbName
shameDB.exists (err, exists) ->
  return console.log 'error', err if err
  return if exists
  console.log 'Creating database '+ dbName
  shameDB.create (err, ok) ->
    # Populate design documents
    shameDB.save '_design/quote',
      views:
        byAuthor:
          map: (doc) ->
            emit doc if doc.author == 'Author'
      validate_doc_update: (newDoc, oldDoc) ->
        if !newDoc.text? or !newDoc.text or newDoc.text == ''
          throw
            forbidden: 'Quote\ must\ not\ be\ empty'

module.exports = shameDB
