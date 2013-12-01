cradle = require 'cradle'
config = require 'config'

cradle.setup {
  host: config.database.host
  port: config.database.port
  auth:
    username: config.database.user
    password: config.database.password
}
shameDB = new(cradle.Connection)

dbName = config.database.prefix+'-quotes'
db = shameDB.database dbName
db.exists (err, exists) ->
  return console.log 'error', err if err
  return if exists
  console.log 'Creating database '+ shameDB.dbName
  db.create()
  # populate design documents

module.exports = shameDB
