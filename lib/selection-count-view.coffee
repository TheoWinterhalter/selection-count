{View, EditorView} = require 'atom'

module.exports =
class SelectionCountView extends View
  @content: ->
    @div class: 'selection-count inline-block'

  initialize: (editorView) ->
    @editorView = editorView

  displayCount: =>
    return unless editor = atom.workspace.getActiveEditor()
    if editor.getSelection().isEmpty()
      @text("nothing (debug)").show()
    else
      count = editor.getSelection().getText().length
      atom.config.observe 'selection-count.displayText', =>
        sidetext = atom.config.get 'selection-count.displayText'
        @text("#{count} #{sidetext}").show()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: =>
    @unsubscribe
    @detach()

  init: ->
    atom.packages.once('activated', @attach)

  attach: =>
    statusbar = atom.workspaceView.statusBar
    atom.config.observe 'selection-count.showOnTheLeft', =>
      if atom.config.get 'selection-count.showOnTheLeft'
        statusbar.appendLeft this
      else
        statusbar.prependRight this

    @subscribe @editorView, "selection:changed", @displayCount
    atom.workspaceView.on 'pane:item-removed', @destroy
