#!/bin/coffe


express = require "express"
path    = require "path"


app = express()


app.configure "development", ->
  app.use express.logger("dev")
  app.use require("connect-livereload")
    port: 35729

app.configure "production", ->

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.use express.static(path.join(__dirname, "/public"))
  app.use express.favicon(__dirname + "/public/img/favicon.ico")
  app.use express.compress()
  app.use [express.json(), express.urlencoded()]


app.listen app.get('port'), ->
  console.log("Serving bitcamp on port " + app.get('port')+".")
