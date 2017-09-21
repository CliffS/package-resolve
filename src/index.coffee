
Path = require 'path'
fs = require 'fs'
JSONutil = require 'jsonutil'

class Package

  constructor: (@module) ->

  resolve: ->
    new Promise (resolve, reject) =>
        path = require.resolve @module
        if path? then resolve path else reject new Error 'File not found'

  package: ->
    check = (path) ->
      new Promise (resolve, reject) =>
        if path is '/' or Path.basename(path) is 'node_modules'
          return reject new Error 'File not found'
        fs.access Path.join(path, 'package.json'), (err) =>
          return resolve path unless err?
          check Path.dirname path
          .then (path) =>
            resolve path
          .catch (err) =>
            reject err
    @resolve()
    .then (path) =>
      check Path.dirname path
    .then (path) =>
      Path.join path, 'package.json'

  readPackage: ->
    @package()
    .then (pack) =>
      new Promise (resolve, reject) =>
        JSONutil.readFile pack, (err, obj) =>
          if err then reject err else resolve obj

  style: ->
    Promise.all [
      @package()
      @readPackage()
    ]
    .then (results) =>
      [path, pack] = results
      Path.join Path.dirname(path), pack.style

  readStyle: ->
    @style()
    .then (path) =>
      new Promise (resolve, reject) =>
        fs.readFile path, (err, data) =>
          if err then reject err else resolve data.toString()

module.exports = Package

