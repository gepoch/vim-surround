helpers = require './spec-helper'

pairs = ['()', '{}', '[]', '""', "''"]

describe "Surround setup", ->
  [editor, editorElement, vimSurround, configPairs] = []

  beforeEach ->
    atom.config.set('vim-surround.pairs', pairs)

    vimSurround = atom.packages.loadPackage('vim-surround')
    vimSurround.activate()

    configPairs = atom.config.get('vim-surround.pairs')

    helpers.getEditorElement (element) ->
      editorElement = element
      editor = editorElement.getModel()

      editorClassList = editorElement.classList

      editorClassList.add('editor')
      editorClassList.add('vim-mode')
      editorClassList.add('visual-mode')

  describe "when the vim-surround module loads", ->
    it "Creates a surround command for each configured pair character", ->
      chars = []
      pairs.forEach (pair) ->
        for i in [0..pair.length-1]
          char = pair[i]
          chars.push char unless char in chars

      commands = atom.commands.findCommands target: editorElement

      names = []
      commands.forEach (command) ->
        names.push(command.name)

      chars.forEach (char) ->
        expect(names).toContain("vim-surround:surround-#{char}")
