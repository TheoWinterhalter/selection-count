SelectionCountView = require './selection-count-view'
charCounters = []

module.exports =
  configDefaults:
    showOnTheLeft: false
    displayedText: "characters selected"

  activate: (state) ->
    atom.workspaceView.eachEditorView (editorView) ->
      counter = new SelectionCountView(editorView)
      counter.init()
      charCounters.push = counter

  deactivate: ->
    for counter in charCounters
      counter.destroy()
