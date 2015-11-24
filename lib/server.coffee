#import a module

http = require('http')
users = require('./users.js')

#declare a http server

http.createServer((req, res) ->
  path = req.url.split('/')
  #localhost:1337/a/b
  # /get/:id
  # /save/name

  if path[1] == 'get'
    users.get path[2], (user) ->
      response = 
        info: 'here your user'
        user: user
      res.writeHead 200, content: 'application/json'
      res.end JSON.stringify(response)
      return
  else if path[1] == 'save'
    users.save path[2], (user) ->
      response = 
        info: 'user saved'
        user: user
      res.writeHead 200, content: 'application/json'
      res.end JSON.stringify(response)
      return
  else
    res.writeHead 404, content: 'text/plain'
    res.end 'not a good path'

  #write a response header
  #res.writeHead(200, {content: 'application/json'});

  return
).listen 1337, '127.0.0.1'

