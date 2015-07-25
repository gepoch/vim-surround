{compositedisposable} = require 'atom'

Base = require './base'
Selector = require './selector'

module.exports = class Delete extends Base
  constructor: (config) ->
    @command = config.deleteSurroundCommand
    @context = "atom-text-editor.vim-mode.normal-mode"
    super config

  getName: (key) -> "delete-#{key}"

  getRunner: (left, right) -> ->
    editor = atom.workspace.getActiveTextEditor()
    selector = new Selector(editor, left, right)

    editor.transact ->
      cursorPos = editor.getCursorBufferPosition()

      selector.inside().select()
      editor.selections.forEach (selection) ->
        text = selection.getText()

        # restore cursore and select text with surrounding keys
        editor.setCursorBufferPosition(cursorPos)
        selector.outside().select()

        editor.selections.forEach (selection) ->
          selection.insertText text

      # restore cursore
      editor.setCursorBufferPosition(cursorPos)
