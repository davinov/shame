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

shameDB.dbPrefix = config.database.prefix

module.exports = shameDB
