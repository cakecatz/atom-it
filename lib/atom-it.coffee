{CompositeDisposable} = require 'atom'
http = require 'http'
qs = require 'querystring'

module.exports = AtomIt =
  atomItView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    console.log 'hello'

    server = http.createServer (req, res) =>
      body = ''
      req.on 'data', (data) ->
        body += data

      req.on 'end', =>
        @addDirectory qs.parse(body).dir

      res.end('hello world')
    server.listen 12345
    # @atomItView = new AtomItView(state.atomItViewState)
    # @modalPanel = atom.workspace.addModalPanel(item: @atomItView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-it:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  addDirectory: (dir) ->
    opendProjects = atom.project.getPaths()
    isOpend = false
    opendProjects.forEach (project) ->
      isOpend = true if project.indexOf(dir) >= 0
      isOpend = true if dir.indexOf(project) >= 0

    unless isOpend
      atom.project.addPath dir

  toggle: ->
    console.log 'AtomIt was toggled!'
