express = require 'express'
path = require 'path'
passport = require 'passport'
facebook = require 'passport-facebook'
config = require 'config'

Quote = require './quote/Quote'

# Configuration
shameApi = express()
shameApi.set 'title', 'Shame'
shameApi.use express.bodyParser()
shameApi.use passport.initialize()

# Frontend
shameApi.use express.static path.join __dirname, "../_public"
shameApi.get '/', (req, res) ->
  res.sendfile 'index.html',
    root: path.join __dirname, '../_public'

# Authentication
passport.use new facebook.Strategy
  clientID: config.facebook.clientID,
  clientSecret: config.facebook.clientSecret,
  callbackURL: "/auth/facebook/callback"
,
  (accessToken, refreshToken, profile, done) ->
    done(profile)

shameApi.get '/auth/facebook', passport.authenticate 'facebook'
shameApi.get '/auth/facebook/callback', passport.authenticate 'facebook',
    successRedirect: '/'
    failureRedirect: '/'

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
