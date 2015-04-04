helpers = require './spec-helper'

pairs = ['()', '{}', '[]', '""', "''"]

describe "Vim Surround activation", ->
  [editor, editorElement, vimSurround, configPairs, chars, names] = []

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
    [chars] = []
    beforeEach ->
      chars = []
      pairs.forEach (pair) ->
        for i in [0..pair.length-1]
          char = pair[i]
          chars.push char unless char in chars

      commands = atom.commands.findCommands target: editorElement

      names = []
      commands.forEach (command) ->
        names.push(command.name)

    it "Creates a surround command for each configured pair character", ->
      chars.forEach (char) ->
        expect(names).toContain("vim-surround:surround-#{char}")

    describe "and then deactivates", ->
      beforeEach ->
        vimSurround.deactivate()

      # it "should clear out all commands from the registry", ->
      #   chars.forEach (char) ->
      #     expect(names).not.toContain("vim-surround:surround-#{char}")
