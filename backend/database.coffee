pg_pool = require('pg').Pool
config = require './config'
pool = new pg_pool config.database

module.exports.exec = (sql, params) ->
    answer = await pool.query sql, params
    answer.rows