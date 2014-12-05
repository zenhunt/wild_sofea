#!/usr/bin/env coffee

express = require 'express'
app = express()

app.get '/groups/list', (req, res) ->
  res.sendFile "#{__dirname}/app/backend-mock/groups/list.json"
app.get '/countries/list', (req, res) ->
  res.sendFile "#{__dirname}/app/backend-mock/countries/list.json"
app.get '/addresses/list', (req, res) ->
  res.sendFile "#{__dirname}/app/backend-mock/addresses/list.json"

app.get '*', (req, res) ->
  res.sendFile "#{__dirname}/dist#{req.path}"

app.listen 9998

console.log 'The demo application is now listening on http://localhost:9998'