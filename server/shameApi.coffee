express = require 'express'
path = require 'path'
passport = require 'passport'
facebookStrategy = require 'passport-facebook'
config = require 'config'

User = require './user/User'
Quote = require './quote/Quote'

# Configuration
shameApi = express()
shameApi.set 'title', 'Shame'
shameApi.set 'trust proxy', true
shameApi.use express.cookieParser()
shameApi.use express.bodyParser()
shameApi.use express.session
  secret: config.cookies.secret
shameApi.use passport.initialize()
shameApi.use passport.session()

# Frontend
shameApi.use express.static path.join __dirname, "../_public"
shameApi.get '/', (req, res) ->
  res.sendfile 'index.html',
    root: path.join __dirname, '../_public'

# Authentication
passport.use new facebookStrategy.Strategy
  profileFields: ['id', 'displayName', 'photos', 'friends']
  clientID: config.facebook.clientID,
  clientSecret: config.facebook.clientSecret,
  callbackURL: '/auth/facebook/callback'
,
(accessToken, refreshToken, profile, done) ->
  User.findOrCreate profile
  done null, profile

shameApi.get '/auth/facebook', passport.authenticate 'facebook'
shameApi.get '/auth/facebook/callback', passport.authenticate 'facebook',
  successRedirect: '/'
  failureRedirect: '/'
passport.serializeUser (user, done) ->
  done null, user
passport.deserializeUser (obj, done) ->
  done null, obj

# API routes
shameApi.use express.logger()
shameApi.get '/feed', Quote.list
shameApi.get '/quote/:id', Quote.get
shameApi.post '/quote', Quote.add
shameApi.post '/quote/:id', Quote.save
shameApi.delete '/quote/:id', Quote.delete
shameApi.get '/me', User.me
shameApi.get '/user/:id', User.get

shameApi.start = (port = 3333, path, callback) ->
  shameApi.listen port, callback
  console.log 'Server listening at port '+port

shameApi.stop = (callback) ->
  shameApi.close callback

module.exports = shameApi
