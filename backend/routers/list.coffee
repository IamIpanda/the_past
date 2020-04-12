koa_router = require 'koa-router'
body_parser = require 'koa-bodyparser'
database = require '../database'
router = koa_router()

SQL = 
    get: "SELECT * FROM fields;"
    add: "INSERT INTO fields values($1, $2);"
    delete: "DELETE FROM fields WHERE name = $1"

router.use body_parser()

router.get '/', (ctx) ->
    ctx.body = await database.exec SQL.get

router.put '/', (ctx) ->
    ctx.body = await database.exec SQL.add, ctx.request.body

router.delete '/:name', (ctx) ->
    ctx.body = await database.exec SQL.delete, [ctx.params.name]

module.exports = router