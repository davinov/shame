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
shameDB = couchDB.database config.name
shameDB.exists (err, exists) ->
  return console.log 'error', err if err
  if not exists
    console.log 'Creating database '+ config.name
    shameDB.create (err, ok) ->
      return

module.exports = shameDB
