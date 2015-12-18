db = require('./db') "#{__dirname}/../db/metrics"

nextKey = null

module.exports =

  ### 
  `get()`
  -------
  returns some hard-coded metrics
  ###

  get: (username, callback) ->
    metrics = {}
    metric = {}
    readstream = db.createReadStream
      gte: "metrics:#{username}"
      lte: "metrics:#{username}"
    readstream.on 'data', (data) ->
      value = data.value.split ':'
      metric.push(timestamp: value[1], value[2])
      return metric

    readstream.on 'error', callback

    readstream.on 'close', ->
      callback null, metric

  ###
  save(id, metrics ,cb)
  ---------------------------------
  save some metrics with a given id

  Parameters:
  'id': an integer defining a batch of metrics
  'metric': An array of objects with a timestamp and a value
  'callback': Callback function called at the end or on error
  ###

  save: (id, metrics, callback) ->
    if !id
      if !nextKey
        keyStream = db.createKeyStream
          reverse: true
          limit: true
        keyStream.on 'data', (data) ->
          if data
            nextKey = parseInt data
          else
            nextKey = 0
          nextKey++
          metrics.id = nextKey
          db.put nextKey, metrics, (error) ->
            callback(metrics.id, error)
      else
        nextKey++
        metrics.id = nextKey
        db.put nextKey, metrics, (error) ->
          callback(metrics.id, error)
    else
      metrics.id = id
      db.put id, metrics, (error) ->
        callback(metrics.id, error)

  delete: (id, callback) ->
    db.del id, callback
