{Disposable, CompositeDisposable} = require 'event-kit'
BaseCommand = require './base-command'

class Surround extends BaseCommand
  constructor: (config) ->
    @command = config.commands.surround
    @context = "atom-text-editor.vim-mode.visual-mode"
    super config

  getName: (key) -> "surround-#{key}"

  getRunner: (left, right) -> ->
    editor = atom.workspace.getActiveTextEditor()
    editor.transact ->
      editor.selections.forEach (selection) ->
        text = selection.getText()
        selection.insertText "#{left}#{text}#{right}"

module.exports = Surround
