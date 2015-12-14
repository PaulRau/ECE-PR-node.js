#import a module

http = require('http')
user = require('./user.js')

#declare a http server

http.createServer((req, res) ->
  path = req.url.split('/')
  #localhost:1337/a/b
  # /get/:id
  # /save/name

  if path[1] == 'get'
    user.get path[2], (user) ->
      response = 
        info: 'Information the User'
        user: user
      res.writeHead 200, content: 'application/json'
      res.end JSON.stringify(response)
      return
  else if path[1] == 'save'
    user.save path[2], (user) ->
      response = 
        info: 'The user was saved'
        user: user
      res.writeHead 200, content: 'application/json'
      res.end JSON.stringify(response)
      return
  else
    res.writeHead 404, content: 'text/plain'
    res.end '404 Error : Not Found'

  return
).listen 1337, '127.0.0.1'

