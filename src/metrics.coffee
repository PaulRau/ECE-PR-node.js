db = require('./db') "#[__dirname}/../db/metrics"

module.exports =

  ### 
  `get()`
  ———————
  returns some hard-coded metrics
  ###

  get: () ->
    return [
      timestamp:(new Date '2013-11-04 14:00 UTC').getTime(), value:12
    ,
      timestamp:(new Date '2013-11-04 14:35 UTC').getTime(), value:15
    ,
      timestamp:(new Date '2013-11-04 14:40 UTC').getTime(), value:17
    ,
      timestamp:(new Date '2013-11-04 14:45 UTC').getTime(), value:18
    ,
      timestamp:(new Date '2013-11-04 14:50 UTC').getTime(), value:19
  ]

  ###
  save(id, metrics ,cb)
  ---------------------------------
  save some metrics with a given id

  Parameters:
  'id': an integer defining a batch of metrics
  'metric': An array of objects with a timestamp and a value
  'callback": Callback function called at the end or on error
  ###

  save: (id, metrics, callback) ->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    for metric in metrics
      {timestamp, value} = metric
      ws.write key: "metric:#{id}:#{timestamp}", value: value
    ws.end()
