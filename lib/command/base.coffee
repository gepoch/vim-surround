{CompositeDisposable} = require 'atom'

module.exports = class Base

  constructor: (config) ->
    @disposables = new CompositeDisposable

    @curPairs = []
    @registerPairs config.pairs

  registerPairs: (pairs) ->
    pairs = (x for x in pairs when x.length > 0 and x.length %2 == 0)

    for pair in pairs
      if pair not in @curPairs
        @registerPair pair
        @curPairs.push(pair)

  registerPair: (pair) ->
    [left, right] = @splitPair(pair)

    if left != right
      @createPairBindings left, "#{left} ", " #{right}"
    @createPairBindings right, left, right

  createPairBindings: (key, left, right) ->
    name = "vim-surround:#{@getName key}"

    # First, we add a command to the system to actually perform the surround.
    # We attach the disposable to our object's list.
    @disposables.add atom.commands.add @context, name, @getRunner left, right

    # Next, we build up keybindings for our command. First, we build a
    # space-delineated version of our key that's passed in. This breaks up
    # double keys like `{%` into the seperate keystroke form: `{ %`
    keys = ""
    for i in [0..key.length-1]
      if i == 0
        keys = key[i]
      else
        keys = "#{keys} #{key[i]}"

    # Making a one-command keymap data structure here. Basically:
    # "atom-text-editor.vim-mode.visual-mode":
    #   "s (":
    #     "vim-surround:surround-("

    keymapArg = {}
    fullCommand = "#{@command} #{keys}"
    keymapArg[fullCommand] = name

    contextArg = {}
    contextArg[@context] = keymapArg

    # Capture the disposable heretom test!
    @disposables.add atom.keymaps.add name, contextArg

  splitPair: (pair) ->
    return [pair[..(pair.length/2)-1], pair[pair.length/2..]]
