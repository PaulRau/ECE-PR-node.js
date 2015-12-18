db = require('./db') "#{__dirname}/../db/metrics"

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
    ws = db.createWriteStream()

    ws.on 'error', callback

    ws.on 'close', callback
    for metric, count in metrics
      {timestamp, value} = metric
      ws.write key: "metric:#{id}:#{count+1}", value: "metrics:#{timestamp}:#{value}"
    console.log "Metrics saved."
    ws.end()
