user = require('./db') "#{__dirname}"/../db/user

module.exports =
  get: (username, callback) ->
    user= {}
    rs = user.createReadStream
      gte = "user:#{username}"
      lte = "user:#{username}"
    rs.on 'data', (data)
      [_, _username] = data.key.slpit ':'
      [_name, _password]

    rs.on 'error', (callback)
    rs.on 'close', ->
      callback null, user

  save: (username, password, name, email, callback) ->

  remove: (username, callback) ->
