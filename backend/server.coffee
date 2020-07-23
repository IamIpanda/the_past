fs = require 'fs'
path = require 'path'
koa = require 'koa'
koa_router = require 'koa-router'
authorization = require './authorization'

app = new koa()
main_router = koa_router()
api_router = koa_router()
api_router.get '/', (ctx) ->
    ctx.body = "The Past 1.0 api server.\nPowered by Koajs"

api_router.use authorization
api_router.use (ctx, next) ->
    #ctx.set 'Access-Control-Allow-Origin', '*'
    #ctx.set 'Access-Control-Allow-Credentials', 'true'
    next()

for file_name in fs.readdirSync './routers'
    continue unless file_name.endsWith '.coffee'
    router_path = path.basename file_name, '.coffee'
    router = require "./routers/#{router_path}"
    api_router.use '/' + router_path, router.routes()
    console.log "router /#{router_path} registered."

main_router.use '/api', api_router.routes()
app.use main_router.routes()

app.listen 40000

console.log "Server has started."