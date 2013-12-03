cradle = require 'cradle'
config = require('config').database

cradle.setup {
  host: config.host
  port: config.port
  auth:
    username: config.user
    password: config.password
}

couchDB = new(cradle.Connection)()
dbName = config.prefix+'-quotes'

shameDB = couchDB.databases dbName
shameDB.exists (err, exists) ->
  return console.log 'error', err if err
  return if exists
  console.log 'Creating database '+ dbName
  shameDB.create()
  # populate design documents

module.exports = shameDB
