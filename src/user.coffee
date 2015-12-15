db = require('./db') "#{__dirname}/../db/user"

module.exports =
  get: (username, callback) ->
    user = {}
    readstream = db.createReadStream
      gte: "user:#{username}"
      lte: "user:#{username}"
    readstream.on 'data', (data) ->
      key: data.key.split ":"
      value: data.value.split ":"
      user: {username : key[1], name : value[1], password : value[2], email : value[3]}
    return user

    readstream.on 'error', (callback)
    readstream.on 'close', ->
      callback null, user

  save: (username, password, name, email, callback) ->
    writestream = db.createWriteStream()
    writestream.write key: "user:#{username}", value: "user:#{name}:#{password}:#{email}"
    console.log "User saved to database."

    writestream.on 'error', callback
    writestream.on 'close', callback
    writestream.end()

  remove: (username, callback) ->
