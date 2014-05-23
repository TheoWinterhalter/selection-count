CharCountView = require './selection-count-view'
charCounters = []

module.exports =
  configDefaults:
    showOnTheLeft: false
    displayText: "characters selected"

  activate: (state) ->
    atom.workspaceView.eachEditorView (editorView) ->
      counter = new CharCountView(editorView)
      counter.init()
      charCounters.push = counter

  deactivate: ->
    for counter in charCounters
      counter.destroy()
