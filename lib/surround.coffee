class Surround
  configDefaults:
    pairs: ['()', '{}', '[]', '""', "''"]
    surroundKey: 's'

  constructor: () ->
    @surroundKey = ""
    @curPairs = []
    @commands = {}
    @keymaps = {}

  activate: (state) ->
    @keymap = atom.keymap

    atom.config.observe 'vim-surround.surroundKey', @setSurroundKey
    atom.config.observe 'vim-surround.pairs', @registerPairs

  setSurroundKey: (surroundKey) =>
    @surroundKey = surroundKey
    if @curPairs
      @curPairs.forEach @deregisterPair
      tmp = @curPairs
      @curPairs = []
      @registerPairs tmp

  registerPairs: (pairs) =>
    pairs = (x for x in pairs when x? and x.length >0 and x.length %2 == 0)

    for pair in pairs
      if pair not in @curPairs
        @registerPair pair

    for pair in @curPairs
      if pair not in pairs
        @deregisterPair pair

    @curPairs = pairs

  registerPair: (pair) =>
    [left, right] = @splitPair(pair)

    if left != right
      @createPairBindings left, "#{left} ", " #{right}"
    @createPairBindings right, left, right

  deregisterPair: (pair) =>
    [left, right] = @splitPair(pair)

    if left != right
      @deletePairBindings(left)
    @deletePairBindings(right)

  splitPair: (pair) ->
    return [pair[..(pair.length/2)-1], pair[pair.length/2..]]

  createPairBindings: (key, left, right) ->
    name = @getCommandName key

    if @commands[name]
      return

    @commands[name] = atom.commands.add(
      "atom-text-editor", name, do (left, right) =>
        @getSurrounder left, right)

    keys = ""

    for i in [0..key.length-1]
      if i == 0
        keys = key[i]
      else
        keys = "#{keys} #{key[i]}"

    # This is done manually, as you cannot use string interpolation in a
    # literal object key definition. The following form works, though.
    keymapArg = {}
    keymapArg["#{@surroundKey} #{keys}"] = name

    @keymaps[name] = @keymap.add name,
      ".editor.vim-mode.visual-mode": keymapArg

  deletePairBindings: (key) ->
    name = @getCommandName(key)

    @commands[name].dispose()
    delete @commands[name]

    @keymaps[name].dispose()
    delete @keymaps[name]

  getCommandName: (key) -> "vim-surround:surround-#{key}"

  getSurrounder: (left, right) -> ->
    editor = atom.workspace.getActiveTextEditor()
    editor.transact ->
      editor.selections.forEach (selection) ->
        text = selection.getText()
        selection.insertText "#{left}#{text}#{right}"

module.exports = new Surround()
