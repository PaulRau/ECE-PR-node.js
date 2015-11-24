module.exports =
  save: (name, callback) ->
    #my code
    user = 
      id: '2222'
      name: name
    callback name
    return
  get: (id, callback) ->
    #get a user
    user = 
      name: 'cesar'
      id: id
    callback id
    return