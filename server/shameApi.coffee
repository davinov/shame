express = require 'express'
path = require 'path'

Quote = require './quote/Quote'

shameApi = express()
shameApi.set 'title', 'Shame'
shameApi.use express.bodyParser()

# Frontend
shameApi.use express.static path.join __dirname, "../_public"
shameApi.get '/', (req, res) ->
  res.sendfile 'index.html',
    root: path.join __dirname, '../_public'

# API routes
shameApi.use express.logger()
shameApi.get '/feed', Quote.list
shameApi.get '/quote/:id', Quote.get
shameApi.post '/quote', Quote.add
shameApi.post '/quote/:id', Quote.save
shameApi.delete '/quote/:id', Quote.delete

shameApi.start = (port = 3333, path, callback) ->
  shameApi.listen port, callback
  console.log 'Server listening at port '+port

shameApi.stop = (callback) ->
  shameApi.close callback

module.exports = shameApi
