http = require 'http'
qs = require 'querystring'

module.exports = AtomIt =
  server_port: 12345

  activate: (state) ->
    @createServer()
    @startServer()

  deactivate: ->
    @server.close()

  createServer: ->
    @server = http.createServer (req, res) =>
      body = ''
      req.on 'data', (data) ->
        body += data

      req.on 'end', =>
        @addDirectory qs.parse(body).dir

      res.end('1')

  startServer: ->
    @server.listen @server_port

  addDirectory: (dir) ->
    opendProjects = atom.project.getPaths()
    isOpend = false

    opendProjects.forEach (project) ->
      isOpend = true if project is dir

    unless isOpend
      atom.project.addPath dir
    else
      atom.project.removePath dir
