{CompositeDisposable} = require 'atom'

Base = require './base'
Selector = require './selector'

module.exports = class Change
  constructor: (config) ->
    @command = config.changeSurroundCommand
    @context = "atom-text-editor.vim-mode.normal-mode"
    @disposables = new CompositeDisposable
    @curPairs = []
    @curPairsWithTarget = []
    @registerPairs config.pairs

  getName: (key, targetKey) -> "change-#{key}-to-#{targetKey}"

  registerPairs: (pairs) ->
    pairs = (x for x in pairs when x.length > 0 and x.length %2 == 0)

    for pair in pairs
      for target in pairs
        if "#{pair}#{target}" not in @curPairs
          @registerPair pair, target
          @curPairs.push("#{pair}#{target}")

  registerPair: (pair, target) ->
    [left, right] = @splitPair(pair)
    [target_left, target_right] = @splitPair(target)

    for key in [left, right]
      for targetKey in [target_left, target_right]
        if "#{key}#{targetKey}" not in @curPairsWithTarget
          name = "vim-surround:#{@getName(key, targetKey)}"

          unless pair == target
            @disposables.add atom.commands.add @context, name, @getRunner pair, target

          keymapArg = {}
          fullCommand = "#{@command} #{key} #{targetKey}"
          keymapArg[fullCommand] = name

          contextArg = {}
          contextArg[@context] = keymapArg

          # Capture the disposable heretom test!
          unless pair == target
            @disposables.add atom.keymaps.add name, contextArg
          @curPairsWithTarget.push("#{key}#{targetKey}")

  splitPair: (pair) ->
    return [pair[..(pair.length/2)-1], pair[pair.length/2..]]

  getRunner: (from, to) -> ->
    [left, right] = [from[0], from[1]]
    [target_left, target_right] = [to[0], to[1]]
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
          selection.insertText "#{target_left}#{text}#{target_right}"

      # restore cursore
      editor.setCursorBufferPosition(cursorPos)
