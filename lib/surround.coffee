class Surround
  configDefaults:
    pairs: ['()', '{}', '[]', '""', "''"]

  constructor: () ->

  activate: (state) ->
    @workspaceView = atom.workspaceView
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
    @workspaceView.command "surround:surround-#{key}", do (left, right) =>
      @getSurrounder left, right

    command = {}
    command["s #{key}"] = "surround:surround-#{key}"

    @keymap.add "surround:surround-#{key}",
      ".editor.vim-mode.visual-mode": command

  getSurrounder: (left, right) -> ->
    editor = atom.workspace.activePaneItem
    selection = editor.getSelection()
    text = selection.getText()
    selection.insertText("#{left}#{text}#{right}")
    atom.workspaceView.getEditorViews().forEach (e) ->
      if e.active
        atom.commands.dispatch(e.element, 'vim-mode:reset-command-mode')

module.exports = new Surround()
