{Disposable, CompositeDisposable} = require 'event-kit'

module.exports = class BaseCommand
  constructor: (config) ->
    @disposables = new CompositeDisposable

    @curPairs = []
    @registerPairs config.pairs

  registerPairs: (pairs) =>
    pairs = (x for x in pairs when x.length > 0 and x.length %2 == 0)

    for pair in pairs
      if pair not in @curPairs
        @registerPair pair
        @curPairs.push(pair)

  registerPair: (pair) =>
    [left, right] = @splitPair(pair)

    if left != right
      @createPairBindings left, "#{left} ", " #{right}"
    @createPairBindings right, left, right

  createPairBindings: (key, left, right) ->
    name = "vim-surround:#{@getName key}"

    @disposables.add atom.commands.add(
      "atom-text-editor.vim-mode", name, do (left, right) =>
        @getRunner left, right)

    keys = ""

    for i in [0..key.length-1]
      if i == 0
        keys = key[i]
      else
        keys = "#{keys} #{key[i]}"

    # This is done manually, as you cannot use string interpolation in a
    # literal object key definition. The following form works, though.
    keymapArg = {}
    fullCommand = "#{@command} #{keys}"
    keymapArg[fullCommand] = name

    contextArg = {}
    contextArg[@context] = keymapArg

    @disposables.add atom.keymap.add name, contextArg

  splitPair: (pair) ->
    return [pair[..(pair.length/2)-1], pair[pair.length/2..]]
