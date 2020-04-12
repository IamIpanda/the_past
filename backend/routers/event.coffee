moment = require 'moment'
koa_router = require 'koa-router'
body_parser = require 'koa-bodyparser'
database = require '../database'
router = koa_router()

SQL =
    get: "SELECT * FROM data WHERE field like $1 and date > $2 and date <= $3"
    post: "INSERT INTO data(field, date, time, note) VALUES($1, now(), now(), '')"
    delete: "DELETE FROM data WHERE id = $1"
    latest: "SELECT * FROM data WHERE field like $1 ORDER BY time DESC LIMIT 1"

router.use body_parser()

router.get '/', (ctx) ->
    field = ctx.query.field || '%'
    start_date = if ctx.query.start_date then moment(ctx.query.start_date) else moment().subtract(7, 'days')
    end_date   = if ctx.query.end_date   then moment(ctx.query.end_date)   else moment()
    ctx.body = await database.exec SQL.get, [field, start_date.format('YYYY-MM-DD'), end_date.format('YYYY-MM-DD')]

router.get '/last', (ctx) ->
    field = ctx.query.field || '%'
    records = await database.exec SQL.latest, [field]
    if records.length == 0
        ctx.body = []
    else
        record = records[0]
        last_time = moment(record.time)
        record.between = moment().diff(last_time, 'days')
        ctx.body = records

router.post '/', (ctx) ->
    json = ctx.request.body
    if typeof json == 'object'
        name = json.name
    else
        name = json
    await database.exec SQL.post, [name]
    ctx.body = 'ok'

router.delete '/:id', (ctx) ->
    await database.exec SQL.delete, [ctx.params.id]
    ctx.body = 'ok'

module.exports = router