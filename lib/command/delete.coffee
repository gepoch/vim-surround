{CompositeDisposable} = require 'atom'

Base = require './base'

module.exports = class Delete extends Base
  constructor: (config) ->
    @command = config.commands.delete
    @context = "atom-text-editor.vim-mode.command-mode"
    super config

  getName: (key) -> "delete-#{key}"

  getRunner: (left, right) -> ->
    editor = atom.workspace.getActiveTextEditor()
    editor.transact ->
      editor.selections.forEach (selection) ->
        text = selection.getText()
        selection.insertText "#{left}#{text}#{right}"
