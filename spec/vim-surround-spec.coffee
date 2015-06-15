helpers = require './spec-helper'

describe "Vim Surround activation", ->
  [editor, pairs, editorElement, vimSurround, configPairs, chars, names] = []

  beforeEach ->
    pairs = ['()', '{}', '[]', '""', "''"]
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


  describe "When the vim-surround module loads", ->
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

    describe "and the list of pairs changes", ->
      beforeEach ->
        pairs = ['()', '{}', '[]', '""', "-+"]
        atom.config.set('vim-surround.pairs', pairs)
        commands = atom.commands.findCommands target: editorElement
        names = (command.name for command in commands)
        chars = []
        pairs.forEach (pair) ->
          for i in [0..pair.length-1]
            char = pair[i]
            chars.push char unless char in chars

      it "should add any new pairs.", ->
        chars.forEach (char) ->
          expect(names).toContain("vim-surround:surround-#{char}")

      it "should remove any old pairs.", ->
        expect(names).not.toContain("vim-surround:surround-'")

    describe "and then deactivates", ->

      beforeEach ->
        vimSurround.deactivate()
        commands = atom.commands.findCommands target: editorElement
        names = (command.name for command in commands)

      it "should clear out all commands from the registry", ->
        chars.forEach (char) ->
          expect(names).not.toContain("vim-surround:surround-#{char}")
