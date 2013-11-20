#!/bin/coffe


express = require "express"
path    = require "path"


app = express()


app.set "port", (process.env.PORT or 3000)
app.use express.favicon(__dirname + "/public/img/favicon.ico")

app.configure "development", ->
  app.use express.logger("dev")
  app.use require("connect-livereload")
    port: 35729

app.configure "production", ->

app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join(__dirname, "/public"))


app.listen app.get('port'), ->
  console.log("Serving bitcamp on port " + app.get('port')+".")
