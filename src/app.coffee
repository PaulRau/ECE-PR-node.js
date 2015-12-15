bodyparser = require 'body-parser'
express = require 'express'
morgan = require 'morgan'
session = require 'express-session'
LevelStore = require('level-session-store')(session)

app = express()
metrics = require './metrics'
user = require './user'

app.set 'port', 1889
app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'jade'
app.use morgan 'dev'
app.use bodyparser.json()
app.use bodyparser.urlencoded()
app.use '/', express.static "#{__dirname}/../public"

app.use session
  secret: 'MyAppSecret'
  store: new LevelStore './db/sessions'
  resave: true
  saveUnitialized: true

authCheck = (request, response, next) ->
  unless request.session.loggedIn == true
    response.redirect '/login'
  else
    next()

app.get '/', authCheck, (request, response) ->
  console.log "get request on root dir"
  response.render 'index'
    ,name: "{request.session.username}"
      ,title: "Paul & Sterling's Test Page"

app.get '/metrics.json', (request, response) ->
  response.status(200).JSON metrics.get()

app.get '/hello/:name', (request, response) ->
  response.status(200).send request.params.name

app.get '/login', (request, response) ->
  response.render 'login'

app.post 'login', (request, response) ->
  user.get request.body.username, (error, data) ->
    if error then throw error
    unless request.body.password == data.password
      response.redirect '/login'
    else
      request.session.loggedIn = true
      request.session.username = request.body.username
      response.redirect '/'

app.get '/signup', (request, response) ->
  response.render 'signup'

app.post 'signup', (request, response) ->
  user.save request.body.username, request.body.password, request.body.email, request.body.name
  if error then throw error
  unless request.body.password == data.password
    reponse.redirect '/signup'
  else
    request.session.loggedIn = true
    request.session.username = request.body.username
    response.redirect '/'

app.post '/metrics/:id.json', (request, response) ->
  metric.save request.params.id, request.body, (error) ->
    if err then response.status(500).json error
    response.status(200).send "Metrics Saved"

app.listen app.get('port'), () ->
console.log "server listening on #{app.get 'port'}"
