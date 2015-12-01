express = require 'express'
app = express()
metrics = require './metrics'
require 'jstransformer-coffee-script'

app.use require('body-parser')()

app.set 'port', 1889
app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'jade'
app.use '/', express.static "#{__dirname}/../public"

app.get '/', (req, res) ->
  res.render 'index', locals: title: 'ECE AST'
			
app.get '/metrics.json', (req,res) ->
res.status(200).JSON metrics.get()
	

app.get '/hello/:name', (req, res) -> res.status(200).send req.params.name
	
	
app.post '/metrics/:id.json', (req, res) -> 
metric.save req.params.id, req.body, (err) ->
if err then res.status(500).json err
res.status(200).send "Metrics Saved"

app.listen app.get('port'), () ->
console.log "server listening on #{app.get 'port'}"
