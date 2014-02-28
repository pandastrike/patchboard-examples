#!/usr/bin/env coffee

Patchboard = require "patchboard"
api = require "../src/api"
Application = require "../src/application"

[interpreter, script, data_file] = process.argv

application = new Application
  data_file: data_file

handlers = require("../src/handlers")(application)


## Playing with new setup usage.
#api = new Patchboard.API definition,
  #url: "http://127.0.0.1:1979/"
  #validate: true
  #decorator: ({context}) =>
    #context.decorate (schema, data) =>
      #if type = schema.id?.split("#")[1]
        #if api.resources[type]?
          #data.url = context.url(type, data)

#server = new Patchboard.Server
  #host: "127.0.0.1"
  #port: 1979
  #dispatcher: new Dispatcher(api)



server = new Patchboard.Server api,
  host: "127.0.0.1"
  port: 1979
  url: "http://127.0.0.1:1979/"
  validate: true
  handlers: handlers
  decorator: ({context}) =>
    context.decorate (schema, data) =>
      if type = schema.id?.split("#")[1]
        if api.resources[type]?
          data.url = context.url(type, data)


server.run()

