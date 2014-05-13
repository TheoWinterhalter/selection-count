CharCountView = require './char-count-view'
charCounters = []

module.exports =

  activate: (state) ->
    atom.workspaceView.eachEditorView (editorView) ->
      counter = new CharCountView(editorView)
      counter.attach()
      charCounters.push = counter

  deactivate: ->
    for counter in charCounters
      counter.destroy()

  serialize: ->
    charCountViewState: @charCounters.serialize()