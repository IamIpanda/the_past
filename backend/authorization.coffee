database = require './database'
users = []

LOAD_USER_SQL = "SELECT * from user"
load_user = ->
    users = await database.exec LOAD_USER_SQL
load_user()

authorization = (ctx, next) ->
    auth = ctx.headers.authorization
    next()
    

module.exports = authorization