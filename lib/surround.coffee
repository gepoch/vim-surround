class Surround
  configDefaults:
    pairs: ['()', '{}', '[]', '""', "''"]

  constructor: () ->

  activate: (state) ->
    @keymap = atom.keymap

    atom.config.observe 'vim-surround.pairs', @registerPairs

  registerPairs: (pairs) =>
    pairs.forEach @registerPair

  registerPair: (pair) =>
    length = pair.length

    left = pair[..(length/2)-1]
    right = pair[length/2..]

    if right != left
      @createPairBindings left, "#{left} ", " #{right}"
    @createPairBindings right, left, right

  createPairBindings: (key, left, right) ->
    atom.commands.add(
      "atom-text-editor", "vim-surround:surround-#{key}", do (left, right) =>
        @getSurrounder left, right)

    keys = ""

    for i in [0..key.length-1]
      if i == 0
        keys = key[i]
      else
        keys = "#{keys} #{key[i]}"

    # This is done manually, as you cannot use string interpolation in a
    # literal object key definition. The following form works, though.
    command = {}
    command["s #{keys}"] = "vim-surround:surround-#{key}"

    @keymap.add "vim-surround:surround-#{key}",
      ".editor.vim-mode.visual-mode": command

  getSurrounder: (left, right) -> ->
    editor = atom.workspace.getActiveTextEditor()
    editor.transact ->
      editor.selections.forEach (selection) ->
        text = selection.getText()
        selection.insertText "#{left}#{text}#{right}"

module.exports = new Surround()
