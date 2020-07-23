koa_router = require 'koa-router'
body_parser = require 'koa-bodyparser'
database = require '../database'
router = koa_router()

SQL = 
    get: "SELECT * FROM fields;"
    add: "INSERT INTO fields values($1, $2);"
    delete: "DELETE FROM fields WHERE name = $1"
    update: "UPDATE fields SET name = $1, color = $2 WHERE name = $3"

router.use body_parser()

router.get '/', (ctx) ->
    ctx.body = await database.exec SQL.get

router.put '/', (ctx) ->
    ctx.body = await database.exec SQL.add, ctx.request.body

router.post '/:name', (ctx) ->
    await database.exec SQL.update, [ctx.request.body..., ctx.params.name]
    ctx.body = 'ok'

router.delete '/:name', (ctx) ->
    ctx.body = await database.exec SQL.delete, [ctx.params.name]

module.exports = router