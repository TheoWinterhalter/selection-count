{View, EditorView} = require 'atom'

module.exports =
class CharCountView extends View
  @content: ->
    @div class: 'char-count inline-block'

  initialize: (editorView) ->
    @editorView = editorView

  displayCount: =>
    return unless editor = atom.workspace.getActiveEditor()
    if editor.getSelection().isEmpty()
      @text("").show()
    else
      count = editor.getSelection().getText().length
      @text("#{count} characters selected").show()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: =>
    @unsubscribe
    @detach()

  attach: =>
    statusbar = atom.workspaceView.statusBar
    statusbar.prependRight this

    @subscribe @editorView, "selection:changed", @displayCount
    atom.workspaceView.on 'pane:item-removed', @destroy
