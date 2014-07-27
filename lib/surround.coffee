
class Surround
  configDefaults:
    pairs: ['()', '{}', '[]', '""', "''"]

  constructor: () ->
    @workspaceView = atom.workspaceView

  activate: (state) ->
    atom.config.observe 'surround.pairs', @registerPairs

  registerPairs: (pairs) =>
    pairs.forEach @registerPair

  registerPair: (pair) =>
    length = pair.length

    left = pair[..(length/2)-1]
    right = pair[length/2..]

    if right != left
      @workspaceView.command "surround:surround-#{left}", ->
        editor = atom.workspace.activePaneItem
        selection = editor.getSelection()
        text = selection.getText()
        selection.insertText("#{left} #{text} #{right}")
        atom.workspaceView.getEditorViews().forEach (e) ->
          if e.active
            e.vimState.activateCommandMode()

    @workspaceView.command "surround:surround-#{right}", ->
      editor = atom.workspace.activePaneItem
      selection = editor.getSelection()
      text = selection.getText()
      selection.insertText("#{left}#{text}#{right}")
      atom.workspaceView.getEditorViews().forEach (e) ->
        if e.active
          e.vimState.activateCommandMode()

module.exports = new Surround()
