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
  shameDB.create()
  # Populate design documents

module.exports = shameDB
