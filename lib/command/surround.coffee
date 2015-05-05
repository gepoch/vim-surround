{CompositeDisposable} = require 'atom'

Base = require './base'

module.exports = class Surround extends Base
  constructor: (config) ->
    @command = config.surroundCommand
    @context = "atom-text-editor.vim-mode.visual-mode"
    super config

  getName: (key) -> "surround-#{key}"

  getRunner: (left, right) -> ->
    editor = atom.workspace.getActiveTextEditor()
    editor.transact ->
      editor.selections.forEach (selection) ->
        text = selection.getText()
        selection.insertText "#{left}#{text}#{right}"
