server_path = "/api"
server_path = "http://localhost:50000/api" if process.env.NODE_ENV == 'development'
server_path = process.env.PUBLIC_URL + "/api" if process.env.PUBLIC_URL

module.exports = 
    server_path: server_path