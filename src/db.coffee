levelup = require 'levelup' 
levelws = require 'level-ws'
#db = levelws levelup "path/to/db_file"

module.exports = (path) ->
  return levelws levelup path
